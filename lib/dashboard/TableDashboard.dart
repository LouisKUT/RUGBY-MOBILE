import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/ScoresProvider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:rugby_mobile/homepage/firestore/TablesProvider.dart';

class DashboardTables extends StatefulWidget {
  @override
  State<DashboardTables> createState() => _DashboardTablesState();
}

class _DashboardTablesState extends State<DashboardTables> {
  final TextEditingController _teamController = TextEditingController();
  final TextEditingController _playedController = TextEditingController();
  final TextEditingController _wonController = TextEditingController();
  final TextEditingController _drawnController = TextEditingController();
  final TextEditingController _lostController = TextEditingController();
  final TextEditingController _pointsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final tablesprovider = Provider.of<TablesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tables Dashboard'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _teamController,
                  decoration: InputDecoration(labelText: 'Team'),
                ),
                TextField(
                  controller: _playedController,
                  decoration: InputDecoration(labelText: 'Played'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _wonController,
                  decoration: InputDecoration(labelText: 'Won'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _drawnController,
                  decoration: InputDecoration(labelText: 'Drawn'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _lostController,
                  decoration: InputDecoration(labelText: 'Lost'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _pointsController,
                  decoration: InputDecoration(labelText: 'Points'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 16.0),
              ElevatedButton(
              onPressed: () {
                tablesprovider.changeName(_teamController.text);
                tablesprovider.changePlayed(_playedController.text);
                tablesprovider.changeWon(_wonController.text);
                tablesprovider.changeDrawn(_drawnController.text);
                tablesprovider.changeLost(_lostController.text);
                tablesprovider.changePoints(_pointsController.text);
        
                tablesprovider.saveTables();
                setState(() {
                  _teamController.clear();
  _playedController.clear();
  _wonController.clear();
  _drawnController.clear();
  _lostController.clear();
  _pointsController.clear();
                });
                 
              },
              child: Text('Post'),
            ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}
