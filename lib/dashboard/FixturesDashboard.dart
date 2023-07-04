import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class FixtureDashboard extends StatefulWidget {
  @override
  _FixtureDashboardState createState() => _FixtureDashboardState();
}

class _FixtureDashboardState extends State<FixtureDashboard> {
  File? teamALogo;
  File? teamBLogo;
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController teamAController = TextEditingController();
  TextEditingController teamBController = TextEditingController();

  Future<void> _pickTeamLogo(bool isTeamA) async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        if (isTeamA) {
          teamALogo = File(pickedImage.path);
        } else {
          teamBLogo = File(pickedImage.path);
        }
      });
    }
  }

  Future<String> _uploadImageToFirebase(File imageFile, String imageName) async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child('logos').child(imageName);
    firebase_storage.UploadTask uploadTask = ref.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    return ref.getDownloadURL();
  }

  Future<void> _saveFixture() async {
    // Upload team logos and get their URLs
    String teamALogoUrl = '';
    String teamBLogoUrl = '';

    if (teamALogo != null) {
      teamALogoUrl = await _uploadImageToFirebase(teamALogo!, 'teamA_logo.jpg');
    }

    if (teamBLogo != null) {
      teamBLogoUrl = await _uploadImageToFirebase(teamBLogo!, 'teamB_logo.jpg');
    }

    // Save fixture data to Firestore
    String date = dateController.text;
    String time = timeController.text;
    String teamA = teamAController.text;
    String teamB = teamBController.text;

    Map<String, dynamic> fixtureData = {
      'date': date,
      'time': time,
      'teamA': teamA,
      'teamALogoUrl': teamALogoUrl,
      'teamB': teamB,
      'teamBLogoUrl': teamBLogoUrl,
    };

    await FirebaseFirestore.instance.collection('fixtures').add(fixtureData);

    // Clear input fields and logos
    setState(() {
      dateController.clear();
      timeController.clear();
      teamAController.clear();
      teamBController.clear();
      teamALogo = null;
      teamBLogo = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fixture Dashboard'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                controller: dateController,
                decoration: InputDecoration(
                  labelText: 'Date',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                ),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: teamAController,
                decoration: InputDecoration(
                  labelText: 'Team A',
                ),
              ),
              SizedBox(height: 16.0),
              teamALogo != null
                  ? Image.file(
                      teamALogo!,
                      height: 100.0,
                      width: 100.0,
                    )
                  : Placeholder(
                      fallbackHeight: 100.0,
                      fallbackWidth: 100.0,
                    ),
              ElevatedButton(
                onPressed: () => _pickTeamLogo(true),
                child: Text('Pick Team A Logo'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: teamBController,
                decoration: InputDecoration(
                  labelText: 'Team B',
                ),
              ),
              SizedBox(height: 16.0),
              teamBLogo != null
                  ? Image.file(
                      teamBLogo!,
                      height: 100.0,
                      width: 100.0,
                    )
                  : Placeholder(
                      fallbackHeight: 100.0,
                      fallbackWidth: 100.0,
                    ),
              ElevatedButton(
                onPressed: () => _pickTeamLogo(false),
                child: Text('Pick Team B Logo'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveFixture,
                child: Text('Save Fixture'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
