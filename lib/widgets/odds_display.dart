import 'package:flutter/material.dart';
import '../models/cricket_match.dart';

class OddsDisplay extends StatelessWidget {
  final MatchOdds odds;

  const OddsDisplay({super.key, required this.odds});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
          child: Text(
            'Current Odds',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOddsColumn('Team 1', odds.team1),
                _buildOddsColumn('Draw', odds.draw),
                _buildOddsColumn('Team 2', odds.team2),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOddsColumn(String label, double value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toStringAsFixed(2),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: label == 'Draw' ? Colors.orange : Colors.green,
          ),
        ),
      ],
    );
  }
}