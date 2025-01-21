import '../models/cricket_match.dart';
import 'dart:math';

class DummyData {
  static CricketMatch getDummyMatch() {
    return CricketMatch(
      id: '1',
      team1: 'Melbourne Stars',
      team2: 'Sydney Thunder',
      team1Score: '156/4',
      team2Score: '89/2',
      currentOver: '12.4',
      matchStatus: 'In Progress',
      odds: MatchOdds(
        team1: 1.85,
        team2: 2.10,
        draw: 15.0,
      ),
      recentEvents: [
        MatchEvent(
          type: 'SIX',
          description: 'Maxwell hits a massive six over long-on!',
          timestamp: '12:45',
        ),
        MatchEvent(
          type: 'WICKET',
          description: 'Bowled! Thompson gets the breakthrough',
          timestamp: '12:42',
        ),
        MatchEvent(
          type: 'FOUR',
          description: 'Beautiful cover drive for four',
          timestamp: '12:40',
        ),
      ],
    );
  }

  static MatchOdds getRandomOdds() {
    final random = Random();
    return MatchOdds(
      team1: double.parse((random.nextDouble() * (3 - 1) + 1).toStringAsFixed(2)),
      team2: double.parse((random.nextDouble() * (3 - 1) + 1).toStringAsFixed(2)),
      draw: double.parse((random.nextDouble() * (20 - 10) + 10).toStringAsFixed(2)),
    );
  }
}