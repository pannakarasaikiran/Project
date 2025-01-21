import 'package:flutter/material.dart';
import '../models/cricket_match.dart';

class MatchHeader extends StatelessWidget {
  final CricketMatch match;

  const MatchHeader({super.key, required this.match});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                match.team1,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const Text(
              'vs',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            Expanded(
              child: Text(
                match.team2,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}