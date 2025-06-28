import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:streakup/ui/responsive/mobile_screen_layout.dart';
import 'package:streakup/ui/views/auth/login_view.dart';
import 'package:streakup/ui/widgets/inputs/custom_date_field.dart';
import 'package:streakup/ui/widgets/inputs/custom_select_field.dart';
import 'package:streakup/ui/widgets/inputs/custom_text_button.dart';
import 'package:streakup/ui/widgets/inputs/custom_text_field.dart';
import 'package:streakup/utils/snackbar.dart';
import 'package:streakup/viewmodels/user_viewmodel.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  int _step = 0;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text.trim() !=
          confirmPasswordController.text.trim()) {
        showSnackBar('Passwords do not match', context);
        return;
      }
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      String res = await userViewModel.registerWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        fullName:
            '${firstNameController.text.trim()} ${lastNameController.text.trim()}',
        profilePhoto: '',
        gender: genderController.text.trim(),
        dateOfBirth:
            DateFormat("dd/MM/yyyy").parse(dateOfBirthController.text.trim()),
      );
      if (res != 'success') {
        showSnackBar(res, context);
      } else {
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MobileScreenLayout()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Register'),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              children: [
                /// Logo
                Image.asset(
                  'assets/logo/Logo_hoz_dark.png',
                  height: 80,
                ),
                const SizedBox(height: 8),

                /// Slogan
                Text(
                  'Build better habits, together.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.outline,
                        fontWeight: FontWeight.w500,
                      ),
                ),

                const SizedBox(height: 30),

                /// Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (_step == 0) ...[
                        /// Section 1: Basic Info

                        CustomTextField(
                          labelText: 'First Name',
                          controller: firstNameController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelText: 'Last Name',
                          controller: lastNameController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelText: 'Email',
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 24),

                        /// Section 2: Security

                        CustomTextField(
                          labelText: 'Password',
                          controller: passwordController,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 12),
                        CustomTextField(
                          labelText: 'Confirm Password',
                          controller: confirmPasswordController,
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 24),
                        CustomButton(
                          label: "Next",
                          color: Theme.of(context).colorScheme.primary,
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (passwordController.text.trim() !=
                                  confirmPasswordController.text.trim()) {
                                showSnackBar("Passwords do not match", context);
                                return;
                              }
                              setState(() => _step = 1);
                            }
                          },
                        ),
                      ] else ...[
                        /// Section 3: Personal Info

                        CustomSelectField(
                          labelText: 'Gender',
                          value: genderController.text.isEmpty
                              ? null
                              : genderController.text,
                          items: ['Male', 'Female'],
                          onChanged: (val) =>
                              setState(() => genderController.text = val!),
                        ),
                        const SizedBox(height: 12),
                        CustomDateField(
                          labelText: 'Date of Birth',
                          controller: dateOfBirthController,
                          initialDate: DateTime.now(),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: CustomButton(
                                label: "Back",
                                color: Theme.of(context)
                                    .colorScheme
                                    .outlineVariant,
                                onPressed: () => setState(() => _step = 0),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: CustomButton(
                                label: "Register",
                                color: Theme.of(context).colorScheme.primary,
                                onPressed: _register,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                /// Register Link
                Center(
                  child: TextButton(
                    style: ButtonStyle(
                      splashFactory: NoSplash.splashFactory,
                      foregroundColor:
                          WidgetStateProperty.all(Colors.transparent),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginView()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "You have an account? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                          TextSpan(
                            text: "Login",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
