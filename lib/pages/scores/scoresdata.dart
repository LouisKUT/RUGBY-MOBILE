import 'package:flutter/material.dart';

class RugbyMatchScore {
  final String teamA;
  final String teamB;
  final int scoreA;
  final int scoreB;
  final String matchTime;

  RugbyMatchScore({
    required this.teamA,
    required this.teamB,
    required this.scoreA,
    required this.scoreB,
    required this.matchTime,
  });
}

class RugbyScoresPage extends StatelessWidget {
  final List<RugbyMatchScore> matchScores = [
    RugbyMatchScore(
      teamA: "Team A",
      teamB: "Team B",
      scoreA: 12,
      scoreB: 18,
      matchTime: "May 20, 2023, 3:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Team C",
      teamB: "Team D",
      scoreA: 22,
      scoreB: 15,
      matchTime: "May 21, 2023, 5:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Team E",
      teamB: "Team F",
      scoreA: 30,
      scoreB: 10,
      matchTime: "May 22, 2023, 2:00 PM",
    ),
    // Add more match scores here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rugby Scores'),
      ),
      body: ListView.builder(
        itemCount: matchScores.length,
        itemBuilder: (context, index) {
          final match = matchScores[index];
          return ListTile(
            title: Text(
              '${match.teamA} vs. ${match.teamB}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text('Match Time: ${match.matchTime}'),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${match.scoreA} - ${match.scoreB}',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
