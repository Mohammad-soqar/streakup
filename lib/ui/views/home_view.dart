import 'package:flutter/material.dart';
import 'package:streakup/ui/widgets/challenge_full_widget.dart';
import 'package:streakup/ui/widgets/challenge_pill_widget.dart';
import 'package:streakup/ui/widgets/create_challenge_first_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home View'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              CreateChallengeFirstWidget(),
              const SizedBox(height: 20),
              ChallengePillWidget(
                text: 'Reading 5 Pages',
                color: Colors.purple,
                emoji: "📚",
                type: 'Type A',
              ),
              const SizedBox(height: 20),
              ChallengeFullWidget(
                text: 'Reading 5 Pages',
                color: Colors.purple,
                emoji: "📚",
                type: 'Type A',
                image: 'assets/images/Reading.png',
              ),
            ],
          ),
        ));
  }
}
