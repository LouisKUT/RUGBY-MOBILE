import 'package:flutter/material.dart';

class RugbyMatch {
  final String teamA;
  final String teamB;
  final String matchTime;
  final bool isWinPrediction;

  RugbyMatch({
    required this.teamA,
    required this.teamB,
    required this.matchTime,
    required this.isWinPrediction,
  });
}

class RugbyMatchPredictionsPage extends StatelessWidget {
  final List<RugbyMatch> matchPredictions = [
    RugbyMatch(
      teamA: "Team A",
      teamB: "Team B",
      matchTime: "May 20, 2023, 3:00 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Team C",
      teamB: "Team D",
      matchTime: "May 21, 2023, 5:30 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Team E",
      teamB: "Team F",
      matchTime: "May 22, 2023, 2:00 PM",
      isWinPrediction: true,
    ),
    // Add more match predictions here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rugby Match Predictions'),
      ),
      body: ListView.builder(
        itemCount: matchPredictions.length,
        itemBuilder: (context, index) {
          final match = matchPredictions[index];
          final winningTeam = match.isWinPrediction ? match.teamA : match.teamB;
          final losingTeam = match.isWinPrediction ? match.teamB : match.teamA;
          return Card(
            child: ListTile(
              title: Text('${match.teamA} vs. ${match.teamB}'),
              subtitle: Text('Time: ${match.matchTime}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Prediction:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${winningTeam} will win',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${losingTeam} will lose',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
