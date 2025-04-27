import 'package:flutter/material.dart';

class CreateChallengeFirstWidget extends StatelessWidget {
  const CreateChallengeFirstWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () {
          // Handle tap event here
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/Createbutton.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
