import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/ScoresProvider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstoriesprovider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';
import 'package:file_picker/file_picker.dart';

class Dashboardscores extends StatefulWidget {
  @override
  State<Dashboardscores> createState() => _DashboardscoresState();
}

class _DashboardscoresState extends State<Dashboardscores> {
  late final storyprovider =
      Provider.of<scoresProvider>(context, listen: false);
  final TextEditingController _teamController = TextEditingController();
  final TextEditingController _opponentController = TextEditingController();
  final TextEditingController _matchTimeController = TextEditingController();
  final TextEditingController _teamScoreController = TextEditingController();
  final TextEditingController _opponentScoreController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scores Dashboard'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _teamController,
              decoration: InputDecoration(labelText: 'Team'),
            ),
            TextField(
              controller: _opponentController,
              decoration: InputDecoration(labelText: 'Opponent'),
            ),
            TextField(
              controller: _matchTimeController,
              decoration: InputDecoration(labelText: 'Match Time'),
            ),
            TextField(
              controller: _teamScoreController,
              decoration: InputDecoration(labelText: "Team's Score"),
            ),
            TextField(
              controller: _opponentScoreController,
              decoration: InputDecoration(labelText: "Opponent's Score"),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                storyprovider.changeMatchTime(_matchTimeController.text);
                storyprovider.changeOpponent(_opponentController.text);
                storyprovider.changeTeam(_teamController.text);
                storyprovider.changeTeamScore(_teamScoreController.text);
                storyprovider.changeOpponentScore(_opponentScoreController.text);
                storyprovider.saveScores();
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
