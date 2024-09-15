import 'package:flutter/material.dart';


class IntroPage2 extends StatelessWidget {
  const IntroPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.speed, // You can change this to any icon you prefer
              size: 100, // Adjust the size as needed
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
            SizedBox(height: 20), // Space between the icon and the text
            Text(
              'Fast and Easy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 10), // Space between the title and the subtitle
            Text(
              'Noter is designed to do one thing and do it well.',
              style: TextStyle(
                fontSize: 16,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
