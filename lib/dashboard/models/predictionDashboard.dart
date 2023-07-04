import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/ScoresProvider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstoriesprovider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rugby_mobile/homepage/firestore/predictionprovider.dart';

class DashboardPredictions extends StatefulWidget {
  @override
  State<DashboardPredictions> createState() => _DashboardPredictionsState();
}

class _DashboardPredictionsState extends State<DashboardPredictions> {
  late final predictionprovider =
      Provider.of<PredictionsProvider>(context, listen: false);
  final TextEditingController _teamController = TextEditingController();
  final TextEditingController _opponentController = TextEditingController();
  final TextEditingController _venueController = TextEditingController();
  final TextEditingController _teamRankController = TextEditingController();
  final TextEditingController _matchTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Predictions Dashboard'),
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
              controller: _venueController,
              decoration: InputDecoration(labelText: 'Venue'),
            ),
            TextField(
              controller: _teamRankController,
              decoration: InputDecoration(labelText: 'Team Rank'),
            ),
            TextField(
              controller: _matchTimeController,
              decoration: InputDecoration(labelText: 'Match Time'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                predictionprovider.changeMatchTime(_matchTimeController.text);
                predictionprovider.changeOpponent(_opponentController.text);
                predictionprovider.changeTeam(_teamController.text);
                predictionprovider.changeTeamRank(_teamRankController.text);
                predictionprovider.changeVenue(_venueController.text);
                predictionprovider.savePredictions();
                setState(() {
                  _teamController.clear();
  _opponentController.clear();
  _venueController.clear();
  _teamRankController.clear();
  _matchTimeController.clear();
                });
                 
                // ...
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}
