import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl = "https://cricbuzz-cricket.p.rapidapi.com/matches/v1/recent";
  final Map<String, String> headers = {
    "x-rapidapi-host": "cricbuzz-cricket.p.rapidapi.com",
    "x-rapidapi-key": "82ef4097e2msh31895c12b589ff5p19476bjsn7cc9b8031c95",
  };

  Future<List<Map<String, dynamic>>> fetchRecentMatches() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), headers: headers);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        List<Map<String, dynamic>> matches = [];

        for (var typeMatch in data["typeMatches"] ?? []) {
          String matchType = typeMatch["matchType"] ?? "Unknown";
          for (var series in typeMatch["seriesMatches"] ?? []) {
            var seriesData = series["seriesAdWrapper"] ?? {};
            String seriesName = seriesData["seriesName"] ?? "Unknown Series";

            for (var match in seriesData["matches"] ?? []) {
              var matchInfo = match["matchInfo"] ?? {};
              var matchScore = match["matchScore"] ?? {};

              matches.add({
                "match_type": matchType,
                "series_name": seriesName,
                "match_desc": matchInfo["matchDesc"] ?? "Unknown Match",
                "team1": matchInfo["team1"]?["teamName"] ?? "Unknown",
                "team2": matchInfo["team2"]?["teamName"] ?? "Unknown",
                "venue": matchInfo["venueInfo"]?["ground"] ?? "Unknown",
                "status": matchInfo["status"] ?? "Unknown",
                "team1_score": matchScore["team1Score"]?["inngs1"]?["runs"] ?? "0",
                "team2_score": matchScore["team2Score"]?["inngs1"]?["runs"] ?? "0",
              });
            }
          }
        }
        return matches;
      } else {
        throw Exception("You have exceeded the DAILY quota for Requests on your current plan, BASIC. Upgrade your plan at https://rapidapi.com/cricketapilive/api/cricbuzz-cricket ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("You have exceeded the DAILY quota for Requests on your current plan, BASIC. Upgrade your plan at https://rapidapi.com/cricketapilive/api/cricbuzz-cricket $e");
    }
  }
}

class RecentMatchesDisplay extends StatelessWidget {
  final Future<List<Map<String, dynamic>>> recentMatches;

  RecentMatchesDisplay({required this.recentMatches});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: recentMatches,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No recent matches found.'));
        } else {
          final matches = snapshot.data!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Matches:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              ...matches.map((match) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Card(
                    elevation: 4.0,
                    child: ListTile(
                      title: Text('${match['team1']} vs ${match['team2']}'),
                      subtitle: Text('${match['status']}'),
                      trailing: Text(
                        '${match['team1_score']} - ${match['team2_score']}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ],
          );
        }
      },
    );
  }
}
