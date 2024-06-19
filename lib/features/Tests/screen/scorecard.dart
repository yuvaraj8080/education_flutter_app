
import 'package:flutter/material.dart';

class Scorecard extends StatelessWidget {
  final int totalMarksScored;
  final int totalQuestions;

  Scorecard({required this.totalMarksScored, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scorecard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Your Score: ${totalMarksScored}/${totalQuestions}',
              style: TextStyle(fontSize: 24),
            ),
            Text(
              'Percentage: ${(totalMarksScored / totalQuestions) * 100}%',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}