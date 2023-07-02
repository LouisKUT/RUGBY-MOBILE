import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';

class TablesProvider with ChangeNotifier {
  final firestoreService = FirestoreServices();

  late String _name;
  late String _played;
  late String _won;
  late String _drawn;
  late String _lost;
  late String _points;

  String get name => _name;
  String get played => _played;
  String get won => _won;
  String get drawn => _drawn;
  String get lost => _lost;
  String get points => _points;

  void changeName(String name) {
    _name = name;
    notifyListeners();
  }

  void changePlayed(String played) {
    _played = played;
    notifyListeners();
  }

  void changeWon(String won) {
    _won = won;
    notifyListeners();
  }

  void changeDrawn(String drawn) {
    _drawn = drawn;
    notifyListeners();
  }

  void changeLost(String lost) {
    _lost = lost;
    notifyListeners();
  }

  void changePoints(String points) {
    _points = points;
    notifyListeners();
  }

  void saveTables() {
    var newTable = Table(
      name: _name,
      played: _played,
      won: _won,
      drawn: _drawn,
      lost: _lost,
      points: _points,
    );
    firestoreService.saveTeamData(newTable);
  }
}

class Table {
  late final String name;
  late final String played;
  late final String won;
  late final String drawn;
  late final String lost;
  late final String points;

  Table({
    required this.name,
    required this.played,
    required this.won,
    required this.drawn,
    required this.lost,
    required this.points,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'played': played,
      'won': won,
      'drawn': drawn,
      'lost': lost,
      'points': points,
    };
  }

  Table.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['name'],
        played = firestore['played'],
        won = firestore['won'],
        drawn = firestore['drawn'],
        lost = firestore['lost'],
        points = firestore['points'];
}

class FirestoreServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveTeamData(Table table) {
    return _db.collection('Tables').doc(table.name).set(table.toMap());
  }

  Stream<List<Topstory>> getstories() {
    return _db.collection('TopStories').snapshots().map((snapshot) =>
        snapshot.docs.map((docs) => Topstory.fromFirestore(docs.data())).toList());
  }
}
