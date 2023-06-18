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
      teamA: "Buffaloes",
      teamB: "Hippos",
      matchTime: "May 20, 2023, 3:00 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Mongers",
      teamB: "Heathens",
      matchTime: "May 21, 2023, 5:30 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Warriors",
      teamB: "Pirates",
      matchTime: "May 22, 2023, 2:00 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Impis",
      teamB: "Kobs",
      matchTime: "May 23, 2023, 4:30 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Rhinos",
      teamB: "Intangas",
      matchTime: "May 24, 2023, 6:00 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Rams",
      teamB: "Rams 2",
      matchTime: "May 25, 2023, 3:30 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Boks",
      teamB: "Sailors",
      matchTime: "May 26, 2023, 7:00 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Walukuba",
      teamB: "Team X",
      matchTime: "May 27, 2023, 4:30 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Team Y",
      teamB: "Team Z",
      matchTime: "May 28, 2023, 6:00 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Team M",
      teamB: "Team N",
      matchTime: "May 29, 2023, 1:30 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Team P",
      teamB: "Team Q",
      matchTime: "May 30, 2023, 3:30 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Team R",
      teamB: "Team S",
      matchTime: "May 31, 2023, 2:00 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Team T",
      teamB: "Team U",
      matchTime: "June 1, 2023, 5:30 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Team V",
      teamB: "Team W",
      matchTime: "June 2, 2023, 7:00 PM",
      isWinPrediction: false,
    ),
    RugbyMatch(
      teamA: "Team AA",
      teamB: "Team BB",
      matchTime: "June 3, 2023, 3:00 PM",
      isWinPrediction: true,
    ),
    RugbyMatch(
      teamA: "Team CC",
      teamB: "Team DD",
      matchTime: "June 4, 2023, 5:30 PM",
      isWinPrediction: false,
    ),
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
            color: Colors.blueGrey[50],
            elevation: 2.0,
            child: ListTile(
              title: Text(
                '${match.teamA} vs. ${match.teamB}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Time: ${match.matchTime}',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Prediction:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${winningTeam} : win',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${losingTeam} : lose',
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
