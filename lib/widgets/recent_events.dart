import 'dart:async';
import 'package:cricket_live_odds/models/cricket_match.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RecentEvents extends StatefulWidget {
  const RecentEvents({super.key, required List<MatchEvent> events});

  @override
  _RecentEventsState createState() => _RecentEventsState();
}

class _RecentEventsState extends State<RecentEvents> {
  late Timer _timer;
  int newsId = 122025;

  @override
  void initState() {
    super.initState();
    // Start the timer to change the newsId every 5 seconds
    _timer = Timer.periodic(const Duration(seconds: 10), _updateNewsId);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _updateNewsId(Timer timer) {
    setState(() {
      // Randomly increase or decrease the newsId
      if (DateTime.now().millisecondsSinceEpoch % 2 == 0) {
        newsId++;
      } else {
        newsId--;
      }
    });
  }

  Future<Map<String, dynamic>> fetchNews() async {
    final response = await http.get(
      Uri.parse('https://cricbuzz-cricket.p.rapidapi.com/news/v1/detail/$newsId'),
      headers: {
        'x-rapidapi-host': 'cricbuzz-cricket.p.rapidapi.com',
        'x-rapidapi-key': '82ef4097e2msh31895c12b589ff5p19476bjsn7cc9b8031c95',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body); // Parsing the JSON response
    } else {
      throw Exception('"You have exceeded the DAILY quota for Requests on your current plan, BASIC. Upgrade your plan at https://rapidapi.com/cricketapilive/api/cricbuzz-cricket"');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchNews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final newsData = snapshot.data;
        final headline = newsData?['headline'] ?? 'No headline available';
        final content = (newsData?['content'] as List)
            .map((contentItem) => contentItem['contentValue'])
            .join('\n\n');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
              child: Text(
                'NEWS',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      headline,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
