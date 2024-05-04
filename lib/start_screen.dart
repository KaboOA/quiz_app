import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_screen.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Quiz App',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22.0,
              ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => QuizScreen(),
                  ),
                );
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: const Text('Start!'),
            ),
          ],
        ),
      ),
    );
  }
}
