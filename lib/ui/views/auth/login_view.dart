import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:streakup/ui/responsive/mobile_screen_layout.dart';
import 'package:streakup/ui/views/auth/register_view.dart';
import 'package:streakup/ui/widgets/inputs/custom_text_button.dart';
import 'package:streakup/ui/widgets/inputs/custom_text_field.dart';
import 'package:streakup/utils/snackbar.dart';
import 'package:streakup/viewmodels/user_viewmodel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      final userViewModel = Provider.of<UserViewModel>(context, listen: false);
      String res = await userViewModel.loginWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
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
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Title
                Text(
                  'Login',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 20),

                /// Logo
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height:
                      keyboardOpen ? screenWidth * 0.25 : screenWidth * 0.45,
                  width: keyboardOpen ? screenWidth * 0.25 : screenWidth * 0.45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/logo/Logo.svg',
                      width:
                          keyboardOpen ? screenWidth * 0.2 : screenWidth * 0.35,
                      colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                /// Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        labelText: 'Email',
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 12),
                      CustomTextField(
                        labelText: 'Password',
                        controller: passwordController,
                        isPassword: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          style: ButtonStyle(
                            splashFactory: NoSplash.splashFactory,
                          ),
                          onPressed: () {
                            //TODO: Implement forgot password functionality
                          },
                          child: Text(
                            'Forgot Password?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      CustomButton(
                        label: "Login",
                        color: Theme.of(context).colorScheme.primary,
                        onPressed: _signIn,
                      ),
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
                            builder: (context) => const RegisterView()),
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "Don’t have an account? ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                          TextSpan(
                            text: "Register",
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
