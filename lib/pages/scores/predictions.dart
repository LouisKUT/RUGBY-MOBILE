import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RugbyMatch {
  final String team;
  final String opponent;
  final String venue;
  final String teamRank;
  final String matchTime;

  RugbyMatch({
    required this.team,
    required this.opponent,
    required this.venue,
    required this.teamRank,
    required this.matchTime,
  });
}

class RugbyMatchPredictionsPage extends StatefulWidget {
  @override
  _RugbyMatchPredictionsPageState createState() =>
      _RugbyMatchPredictionsPageState();
}

class _RugbyMatchPredictionsPageState
    extends State<RugbyMatchPredictionsPage> {
  final CollectionReference _predictionsCollection =
      FirebaseFirestore.instance.collection('Predictions');
  var prediction;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final querySnapshot = await _predictionsCollection.get();
    final predictionDocs = querySnapshot.docs;

    for (final doc in predictionDocs) {
      final matchData = MatchData.fromSnapshot(doc);
      final prediction = await sendInputData(
        matchData.team.replaceAll(' ', ''),
        matchData.opponent.replaceAll(' ', ''),
        matchData.venue.replaceAll(' ', ''),
        int.parse(matchData.teamRank),
      );
      setState(() {
        matchData.prediction = prediction;
      });
    }
  }

  Future<String> sendInputData(
    String team,
    String opponent,
    String venue,
    int teamRank,
  ) async {
    // var inputData = {
    //   'data': [teamRank]
    // };
    
int transMath(String word) {
  if (word == 'Buffaloes') {
    return 1;
  } else if (word == 'Hippos') {
    return 2;
  } else if (word == 'Mongers') {
    return 3;
  } else if (word == 'Heathens') {
    return 4;
  } else if (word == 'Warriors') {
    return 5;
  } else if (word == 'Pirates') {
    return 6;
  } else if (word == 'Impis') {
    return 7;
  } else if (word == 'Kobs') {
    return 8;
  } else if (word == 'Rhinos') {
    return 9;
  } else if (word == 'Intangas') {
    return 10;
  } else if (word == 'Rams') {
    return 11;
  } else if (word == 'Boks') {
    return 12;
  } else if (word == 'Sailors') {
    return 13;
  } else if (word == 'Walukuba') {
    return 14;
  } else if (word == 'Jaguars') {
    return 15;
  } else if (word == 'Thunderbirds') {
    return 16;
  } else if (word == 'Ewes') {
    return 17;
  } else if (word == 'Avengers') {
    return 18;
  } else if (word == 'Panthers') {
    return 19;
  } else if (word == 'Rams 2') {
    return 20;
  } else {
    return 0; // Return 0 or handle the case when the word is not found
  }
}
int trans(String word) {
  if (word == 'Home') {
    return 1;
  } else if (word == 'Away') {
    return 0;
  } else {
    return 5; // Return 0 or handle the case when the word is not found
  }
}


  int teamCode = transMath(team);
  int opponentCode = transMath(opponent);
  int venueCode = trans(venue);
var inputData = {
     'data': [[teamCode, opponentCode, venueCode, teamRank]]
   };
   print('=============translated data ====================');
    //print(teamCode + opponentCode + venueCode + teamRank);
    print("teamcode" + "(" +team + "): " + teamCode.toString());
    print("oppnentcode" + "(" +opponent + "): "+ opponentCode.toString());
    print("venuecode" + "(" +venue + "): "+ venueCode.toString());
    print("rankcode" + "(" +teamRank.toString() + "): " + teamRank.toString());
// var inputData = {
//      'data': [[7, 10, 1, 3]]
//    };
    var url = 'https://prediction-sever-cfe8b65b-c58f-4c8b-92fe.cranecloud.io/result/';

    var response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(inputData),
    );

    if (response.statusCode == 200) {
      print("Successfully sent the input data");
      final prediction = jsonDecode(response.body)['prediction'];
      print('Prediction: $prediction');
      return prediction;
    } else {
      print('Failed to send input data. Error: ${response.statusCode}');
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prediction odds'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _predictionsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final predictionDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: predictionDocs.length,
            itemBuilder: (context, index) {
              final doc = predictionDocs[index];
              final matchData = MatchData.fromSnapshot(doc);
              final prediction = matchData.prediction;

              return Card(
                color: Colors.blueGrey[50],
                elevation: 2.0,
                child: ListTile(
                  title: Text(
                    '${matchData.team.replaceAll(' ', '')} vs. ${matchData.opponent.replaceAll(' ', '')}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Venue: ${matchData.venue.replaceAll(' ', '')}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                      Text(
                        'Time: ${matchData.matchTime}',
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  trailing:FutureBuilder<String>(
  future: sendInputData(
    matchData.team,
    matchData.opponent,
    matchData.venue,
    int.parse(matchData.teamRank),
  ),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return CircularProgressIndicator();
    } else if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      final prediction = snapshot.data ?? '';
      String teamResult;
      String opponentResult;
      Color teamColor;
      Color opponentColor;

      if (prediction == 'Loss') {
        teamResult = 'Loss';
        opponentResult = 'Win';
        teamColor = Colors.red;
        opponentColor = Colors.green;
      } else if (prediction == 'Win') {
        teamResult = 'Win';
        opponentResult = 'Loss';
        teamColor = Colors.green;
        opponentColor = Colors.red;
      } else {
        teamResult = '';
        opponentResult = '';
        teamColor = Colors.black;
        opponentColor = Colors.black;
      }

      return Column(
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
            '${matchData.team} : $teamResult',
            style: TextStyle(
              color: teamColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '${matchData.opponent} : $opponentResult',
            style: TextStyle(
              color: opponentColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      );
    }
  },
),


                ),
              );
            },
          );
        },
      ),
    );
  }
}

class MatchData {
  final String team;
  final String opponent;
  final String venue;
  final String teamRank;
  final String matchTime;
  String prediction;

  MatchData({
    required this.team,
    required this.opponent,
    required this.venue,
    required this.teamRank,
    required this.matchTime,
    required this.prediction,
  });

  factory MatchData.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return MatchData(
      team: data['team'] ?? '',
      opponent: data['opponent'] ?? '',
      venue: data['venue'] ?? '',
      teamRank: data['teamRank'] ?? '0',
      matchTime: data['matchTime'] ?? '',
      prediction: '',
    );
  }
}











// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class RugbyMatch {
//   final String team;
//   final String opponent;
//   final String venue;
//   final int teamRank;
//   final String matchTime;

//   RugbyMatch({
//     required this.team,
//     required this.opponent,
//     required this.venue,
//     required this.teamRank,
//     required this.matchTime,
//   });
// }

// class RugbyMatchPredictionsPage extends StatelessWidget {
//   final CollectionReference _predictionsCollection =
//       FirebaseFirestore.instance.collection('Predictions');
//          @override
//   void initState() {
    
//     // Call your method here
//     //sendInputData();
    
//   }
//   var prediction;

//   Future<void> sendInputData() async {
//   var inputData = {
//     'data': [[7, 10, 1, 3]]
//   };

//   var url = 'https://prediction-sever-cfe8b65b-c58f-4c8b-92fe.cranecloud.io/result/';

//   var response = await http.post(
//     Uri.parse(url),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(inputData),
//   );

//   if (response.statusCode == 200) {
//     print("Successfully sent the input data");
//     prediction = jsonDecode(response.body)['prediction'];
//     print('Prediction: $prediction');
//   } else {
//     print('Failed to send input data. Error: ${response.statusCode}');
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Prediction odds'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: _predictionsCollection.snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           }

//           if (!snapshot.hasData) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final predictionDocs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: predictionDocs.length,
//             itemBuilder: (context, index) {
//               final doc = predictionDocs[index];
//               final matchData = MatchData.fromSnapshot(doc);

//               return Card(
//                 color: Colors.blueGrey[50],
//                 elevation: 2.0,
//                 child: ListTile(
//                   title: Text(
//                     '${matchData.team} vs. ${matchData.opponent}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Venue: ${matchData.venue}',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                       Text(
//                         'Time: ${matchData.matchTime}',
//                         style: TextStyle(
//                           color: Colors.grey[600],
//                         ),
//                       ),
//                     ],
//                   ),
//                   trailing: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
                      
//                       Text(
//                         'Prediction:',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         '${matchData.team} :  ${prediction}',
//                         style: TextStyle(
//                           color: Colors.green,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         '${matchData.opponent} : ${prediction}',
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }

// class MatchData {
//   final String team;
//   final String opponent;
//   final String venue;
//   final String teamRank;
//   final String matchTime;
//   //final String prediction;

//   MatchData({
//     required this.team,
//     required this.opponent,
//     required this.venue,
//     required this.teamRank,
//     required this.matchTime,
//     //required this.prediction,
//   });

//   factory MatchData.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return MatchData(
//       team: data['team'] ?? '',
//       opponent: data['opponent'] ?? '',
//       venue: data['venue'] ?? '',
//       teamRank: data['teamRank'] ?? 0,
//       matchTime: data['matchTime'] ?? '',
//      // prediction: data['prediction'] ?? '',
//     );
//   }
// }








// class RugbyMatch {
//   final String teamA;
//   final String teamB;
//   final String matchTime;
//   final bool isWinPrediction;

//   RugbyMatch({
//     required this.teamA,
//     required this.teamB,
//     required this.matchTime,
//     required this.isWinPrediction,
//   });
// }

// class RugbyMatchPredictionsPage extends StatefulWidget {
//   @override
//   State<RugbyMatchPredictionsPage> createState() => _RugbyMatchPredictionsPageState();
// }

// class _RugbyMatchPredictionsPageState extends State<RugbyMatchPredictionsPage> {
//    @override
//   void initState() {
//     super.initState();
//     // Call your method here
//     //sendInputData();
//   }
//   var prediction;

//   Future<void> sendInputData() async {
//   var inputData = {
//     'data': [[7, 10, 1, 3]]
//   };

//   var url = 'http://127.0.0.1:8000/result/';

//   var response = await http.post(
//     Uri.parse(url),
//     headers: {'Content-Type': 'application/json'},
//     body: jsonEncode(inputData),
//   );

//   if (response.statusCode == 200) {
//     print("Successfully sent the input data");
//     prediction = jsonDecode(response.body)['prediction'];
//     print('Prediction: $prediction');
//   } else {
//     print('Failed to send input data. Error: ${response.statusCode}');
//   }
// }

  // final List<RugbyMatch> matchPredictions = [
  //   RugbyMatch(
  //     teamA: "Buffaloes",
  //     teamB: "Hippos",
  //     matchTime: "May 20, 2023, 3:00 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Mongers",
  //     teamB: "Heathens",
  //     matchTime: "May 21, 2023, 5:30 PM",
  //     isWinPrediction: false,
  //   ),
  //   RugbyMatch(
  //     teamA: "Warriors",
  //     teamB: "Pirates",
  //     matchTime: "May 22, 2023, 2:00 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Impis",
  //     teamB: "Kobs",
  //     matchTime: "May 23, 2023, 4:30 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Rhinos",
  //     teamB: "Intangas",
  //     matchTime: "May 24, 2023, 6:00 PM",
  //     isWinPrediction: false,
  //   ),
  //   RugbyMatch(
  //     teamA: "Rams",
  //     teamB: "Rams 2",
  //     matchTime: "May 25, 2023, 3:30 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Boks",
  //     teamB: "Sailors",
  //     matchTime: "May 26, 2023, 7:00 PM",
  //     isWinPrediction: false,
  //   ),
  //   RugbyMatch(
  //     teamA: "Walukuba",
  //     teamB: "Team X",
  //     matchTime: "May 27, 2023, 4:30 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team Y",
  //     teamB: "Team Z",
  //     matchTime: "May 28, 2023, 6:00 PM",
  //     isWinPrediction: false,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team M",
  //     teamB: "Team N",
  //     matchTime: "May 29, 2023, 1:30 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team P",
  //     teamB: "Team Q",
  //     matchTime: "May 30, 2023, 3:30 PM",
  //     isWinPrediction: false,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team R",
  //     teamB: "Team S",
  //     matchTime: "May 31, 2023, 2:00 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team T",
  //     teamB: "Team U",
  //     matchTime: "June 1, 2023, 5:30 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team V",
  //     teamB: "Team W",
  //     matchTime: "June 2, 2023, 7:00 PM",
  //     isWinPrediction: false,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team AA",
  //     teamB: "Team BB",
  //     matchTime: "June 3, 2023, 3:00 PM",
  //     isWinPrediction: true,
  //   ),
  //   RugbyMatch(
  //     teamA: "Team CC",
  //     teamB: "Team DD",
  //     matchTime: "June 4, 2023, 5:30 PM",
  //     isWinPrediction: false,
  //   ),
  // ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Rugby Match Predictions'),
//       ),
//       body: ListView.builder(
//         itemCount: matchPredictions.length,
//         itemBuilder: (context, index) {
//           final match = matchPredictions[index];
//           final winningTeam = match.isWinPrediction ? match.teamA : match.teamB;
//           final losingTeam = match.isWinPrediction ? match.teamB : match.teamA;
//          // sendInputData();
//           return Card(
//             color: Colors.blueGrey[50],
//             elevation: 2.0,
//             child: ListTile(
              
//               title: Text(
//                 '${match.teamA} vs. ${match.teamB}',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               subtitle: Text(
//                 'Time: ${match.matchTime}',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                 ),
//               ),
//               trailing: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     'Prediction:',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${winningTeam} :  ${prediction}',
//                     style: TextStyle(
//                       color: Colors.green,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '${losingTeam} : ${prediction}',
//                     style: TextStyle(
//                       color: Colors.red,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
