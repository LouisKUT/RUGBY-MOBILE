import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';

class PredictionsProvider with ChangeNotifier {
  final firestoreService = FirestoreServices();

  late String _team;
  late String _opponent;
  late String _venue;
  late String _teamRank;
  late String _matchTime;

  String get team => _team;
  String get opponent => _opponent;
  String get venue => _venue;
  String get teamRank => _teamRank;
  String get matchTime => _matchTime;

  void changeTeam(String team) {
    _team = team;
    notifyListeners();
  }

  void changeOpponent(String opponent) {
    _opponent = opponent;
    notifyListeners();
  }

  void changeVenue(String venue) {
    _venue = venue;
    notifyListeners();
  }

  void changeTeamRank(String teamRank) {
    _teamRank = teamRank;
    notifyListeners();
  }

  void changeMatchTime(String matchTime) {
    _matchTime = matchTime;
    notifyListeners();
  }

  void savePredictions() {
    var newPrediction = Prediction(
      team: _team,
      opponent: _opponent,
      venue: _venue,
      teamRank: _teamRank,
      matchTime: _matchTime,
    );
    firestoreService.savePrediction(newPrediction);
  }
}

class Prediction {
  late final String team;
  late final String opponent;
  late final String venue;
  late final String teamRank;
  late final String matchTime;

  Prediction({
    required this.team,
    required this.opponent,
    required this.venue,
    required this.teamRank,
    required this.matchTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'team': team,
      'opponent': opponent,
      'venue': venue,
      'teamRank': teamRank,
      'matchTime': matchTime,
    };
  }

  Prediction.fromFirestore(Map<String, dynamic> firestore)
      : team = firestore['team'],
        opponent = firestore['opponent'],
        venue = firestore['venue'],
        teamRank = firestore['teamRank'],
        matchTime = firestore['matchTime'];
}

class FirestoreServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> savePrediction(Prediction prediction) {
    return _db.collection('Predictions').doc(prediction.matchTime).set(prediction.toMap());
  }

  Stream<List<Topstory>> getStories() {
    return _db
        .collection('TopStories')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((docs) => Topstory.fromFirestore(docs.data()))
            .toList());
  }
}
