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

            teams.sort((a, b) => (b['points'] as int).compareTo(a['points'] as int));

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
