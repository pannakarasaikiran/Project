class CricketMatch {
  final String id;
  final String team1;
  final String team2;
  final String team1Score;
  final String team2Score;
  final String currentOver;
  final String matchStatus;
  final MatchOdds odds;
  final List<MatchEvent> recentEvents;

  CricketMatch({
    required this.id,
    required this.team1,
    required this.team2,
    required this.team1Score,
    required this.team2Score,
    required this.currentOver,
    required this.matchStatus,
    required this.odds,
    required this.recentEvents,
  });
}

class MatchOdds {
  final double team1;
  final double team2;
  final double draw;

  MatchOdds({
    required this.team1,
    required this.team2,
    required this.draw,
  });
}

class MatchEvent {
  final String type;
  final String description;
  final String timestamp;

  MatchEvent({
    required this.type,
    required this.description,
    required this.timestamp,
  });
}