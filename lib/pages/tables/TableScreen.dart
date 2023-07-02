import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LeagueTablePage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('League Table'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[200]!, Colors.blue[800]!],
          ),
        ),
        child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: _firestore.collection('Tables').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            final teams = snapshot.data!.docs.map((doc) => doc.data()).toList();

            return ListView(
              children: [
                DataTable(
                  headingTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  dataTextStyle: TextStyle(color: Colors.white),
                  columnSpacing: 16.0,
                  columns: [
                    DataColumn(
                      label: Text('Pos'),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('Team'),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text('P'),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('W'),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('D'),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('L'),
                      numeric: true,
                    ),
                    DataColumn(
                      label: Text('Pts'),
                      numeric: true,
                    ),
                  ],
                  rows: teams
                      .asMap()
                      .map(
                        (index, team) => MapEntry(
                          index,
                          DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  (index + 1).toString(),
                                ),
                              ),
                              DataCell(
                                Text(
                                  team['name']?.toString() ?? '',
                                ),
                              ),
                              DataCell(
                                Text(team['played']?.toString() ?? ''),
                              ),
                              DataCell(
                                Text(team['won']?.toString() ?? ''),
                              ),
                              DataCell(
                                Text(team['drawn']?.toString() ?? ''),
                              ),
                              DataCell(
                                Text(team['lost']?.toString() ?? ''),
                              ),
                              DataCell(
                                Text(
                                  team['points']?.toString() ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .values
                      .toList(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}





// import 'package:flutter/material.dart';

// class LeagueTablePage extends StatelessWidget {
//   final List<Map<String, dynamic>> teams = [
//     {'name': 'Buffaloes', 'played': 10, 'won': 7, 'drawn': 2, 'lost': 1, 'points': 23},
//     {'name': 'Hippos', 'played': 10, 'won': 6, 'drawn': 2, 'lost': 2, 'points': 20},
//     {'name': 'Mongers', 'played': 10, 'won': 5, 'drawn': 3, 'lost': 2, 'points': 18},
//     {'name': 'Heathens', 'played': 10, 'won': 4, 'drawn': 4, 'lost': 2, 'points': 16},
//     {'name': 'Warriors', 'played': 10, 'won': 4, 'drawn': 3, 'lost': 3, 'points': 15},
//     {'name': 'Pirates', 'played': 10, 'won': 4, 'drawn': 2, 'lost': 4, 'points': 14},
//     {'name': 'Impis', 'played': 10, 'won': 3, 'drawn': 4, 'lost': 3, 'points': 13},
//     {'name': 'Kobs', 'played': 10, 'won': 3, 'drawn': 3, 'lost': 4, 'points': 12},
//     {'name': 'Rhinos', 'played': 10, 'won': 2, 'drawn': 5, 'lost': 3, 'points': 11},
//     {'name': 'Intangas', 'played': 10, 'won': 2, 'drawn': 4, 'lost': 4, 'points': 10},
//     {'name': 'Rams', 'played': 10, 'won': 2, 'drawn': 3, 'lost': 5, 'points': 9},
//     {'name': 'Rams 2', 'played': 10, 'won': 1, 'drawn': 4, 'lost': 5, 'points': 7},
//     {'name': 'Boks', 'played': 10, 'won': 1, 'drawn': 3, 'lost': 6, 'points': 6},
//     {'name': 'Saliors', 'played': 10, 'won': 1, 'drawn': 2, 'lost': 7, 'points': 5},
//     {'name': 'Walukuba', 'played': 10, 'won': 0, 'drawn': 4, 'lost': 6, 'points': 4},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('League Table'),
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue[200]!, Colors.blue[800]!],
//           ),
//         ),
//         child: ListView(
//           children: [
//             DataTable(
//               headingTextStyle: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//               ),
//               dataTextStyle: TextStyle(color: Colors.white),
//               columnSpacing: 16.0,
//               columns: [
//                 DataColumn(
//                   label: Text('Pos'),
//                   numeric: true,
//                 ),
//                 DataColumn(
//                   label: Text('Team'),
//                   numeric: false,
//                 ),
//                 DataColumn(
//                   label: Text('P'),
//                   numeric: true,
//                 ),
//                 DataColumn(
//                   label: Text('W'),
//                   numeric: true,
//                 ),
//                 DataColumn(
//                   label: Text('D'),
//                   numeric: true,
//                 ),
//                 DataColumn(
//                   label: Text('L'),
//                   numeric: true,
//                 ),
//                 DataColumn(
//                   label: Text('Pts'),
//                   numeric: true,
//                 ),
//               ],
//               rows: teams
//                   .asMap()
//                   .map(
//                     (index, team) => MapEntry(
//                       index,
//                       DataRow(
//                         cells: [
//                           DataCell(
//                             Text(
//                               (index + 1).toString(),
//                             ),
//                           ),
//                           DataCell(
//                             Text(
//                               team['name'],
//                             ),
//                           ),
//                           DataCell(
//                             Text(team['played'].toString()),
//                           ),
//                           DataCell(
//                             Text(team['won'].toString()),
//                           ),
//                           DataCell(
//                             Text(team['drawn'].toString()),
//                           ),
//                           DataCell(
//                             Text(team['lost'].toString()),
//                           ),
//                           DataCell(
//                             Text(
//                               team['points'].toString(),
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                   .values
//                   .toList(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
