import 'package:cricket_live_odds/screens/apiservice.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../models/cricket_match.dart';
import '../data/dummy_data.dart';
import '../widgets/match_header.dart';
import '../widgets/score_board.dart';
import '../widgets/odds_display.dart';
import '../widgets/recent_events.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CricketMatch match;
  Timer? _timer;
  bool isDarkMode = true;  // State for dark/light mode toggle


  void initState() {
    super.initState();
    match = DummyData.getDummyMatch();
    startPolling();
  }

  void startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      refreshData();
    });
  }

  void refreshData() {
    setState(() {
      match = CricketMatch(
        id: match.id,
        team1: match.team1,
        team2: match.team2,
        team1Score: match.team1Score,
        team2Score: match.team2Score,
        currentOver: match.currentOver,
        matchStatus: match.matchStatus,
        odds: DummyData.getRandomOdds(),
        recentEvents: match.recentEvents,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Toggle dark mode
  void toggleDarkMode() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    return MaterialApp(
      theme: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.blue,
        appBarTheme: AppBarTheme(
          backgroundColor: isDarkMode ? Colors.black : Colors.blue,
        ),
        scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,
        textTheme: TextTheme(
          bodyLarge: TextStyle(
            color: isDarkMode ? Colors.black : Colors.white,
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('GOTO SIOC'),
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: toggleDarkMode,
            ),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            refreshData();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  MatchHeader(match: match),
                  const SizedBox(height: 16),
                  ScoreBoard(match: match),
                  const SizedBox(height: 16),
                  OddsDisplay(odds: match.odds),
                  const SizedBox(height: 16),
                  RecentEvents(events: match.recentEvents),
                   const SizedBox(height: 16),
          RecentMatchesDisplay(recentMatches: apiService.fetchRecentMatches()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
