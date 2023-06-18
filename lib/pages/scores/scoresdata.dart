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
      teamA: "Buffaloes",
      teamB: "Hippos",
      scoreA: 12,
      scoreB: 18,
      matchTime: "May 20, 2023, 3:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Mongers",
      teamB: "Heathens",
      scoreA: 22,
      scoreB: 15,
      matchTime: "May 21, 2023, 5:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Warriors",
      teamB: "Pirates",
      scoreA: 30,
      scoreB: 10,
      matchTime: "May 22, 2023, 2:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Impis",
      teamB: "Kobs",
      scoreA: 16,
      scoreB: 24,
      matchTime: "May 23, 2023, 4:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Rhinos",
      teamB: "Intangas",
      scoreA: 14,
      scoreB: 18,
      matchTime: "May 24, 2023, 6:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Rams",
      teamB: "Rams 2",
      scoreA: 20,
      scoreB: 20,
      matchTime: "May 25, 2023, 3:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Boks",
      teamB: "Sailors",
      scoreA: 8,
      scoreB: 15,
      matchTime: "May 26, 2023, 7:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Walukuba",
      teamB: "Team X",
      scoreA: 10,
      scoreB: 7,
      matchTime: "May 27, 2023, 4:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Team Y",
      teamB: "Team Z",
      scoreA: 25,
      scoreB: 30,
      matchTime: "May 28, 2023, 6:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Team M",
      teamB: "Team N",
      scoreA: 19,
      scoreB: 22,
      matchTime: "May 29, 2023, 1:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Team P",
      teamB: "Team Q",
      scoreA: 14,
      scoreB: 11,
      matchTime: "May 30, 2023, 3:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Team R",
      teamB: "Team S",
      scoreA: 9,
      scoreB: 6,
      matchTime: "May 31, 2023, 2:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Team T",
      teamB: "Team U",
      scoreA: 16,
      scoreB: 20,
      matchTime: "June 1, 2023, 5:30 PM",
    ),
    RugbyMatchScore(
      teamA: "Team V",
      teamB: "Team W",
      scoreA: 13,
      scoreB: 17,
      matchTime: "June 2, 2023, 7:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Team AA",
      teamB: "Team BB",
      scoreA: 23,
      scoreB: 19,
      matchTime: "June 3, 2023, 3:00 PM",
    ),
    RugbyMatchScore(
      teamA: "Team CC",
      teamB: "Team DD",
      scoreA: 27,
      scoreB: 30,
      matchTime: "June 4, 2023, 5:30 PM",
    ),
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
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2A75BC), Color(0xFF3E8ACB)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListTile(
              title: Text(
                '${match.teamA} vs. ${match.teamB}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                'Match Time: ${match.matchTime}',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${match.scoreA} - ${match.scoreB}',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
