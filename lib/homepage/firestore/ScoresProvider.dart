import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';

class scoresProvider with ChangeNotifier {
  final firestoreService = FirestoreServices();

  late String _team;
  late String _opponent;
  late String _matchTime;
  late String _teamScore;
  late String _opponentScore;

  String get team => _team;
  String get opponent => _opponent;
  String get matchTime => _matchTime;
  String get teamScore => _teamScore;
  String get opponentScore => _opponentScore;

  void changeTeam(String team) {
    _team = team;
    notifyListeners();
  }

  void changeOpponent(String opponent) {
    _opponent = opponent;
    notifyListeners();
  }

  void changeMatchTime(String matchTime) {
    _matchTime = matchTime;
    notifyListeners();
  }

  void changeTeamScore(String teamScore) {
    _teamScore = teamScore;
    notifyListeners();
  }

  void changeOpponentScore(String opponentScore) {
    _opponentScore = opponentScore;
    notifyListeners();
  }

  void saveScores() {
    var newScore = Score(
      team: _team,
      opponent: _opponent,
      matchTime: _matchTime,
      teamScore: _teamScore,
      opponentScore: _opponentScore,
    );
    firestoreService.savescore(newScore);
  }
}

class Score {
  late final String team;
  late final String opponent;
  late final String matchTime;
  late final String teamScore;
  late final String opponentScore;

  Score({
    required this.team,
    required this.opponent,
    required this.matchTime,
    required this.teamScore,
    required this.opponentScore,
  });

  Map<String, dynamic> toMap() {
    return {
      'team': team,
      'opponent': opponent,
      'matchTime': matchTime,
      'teamScore': teamScore,
      'opponentScore': opponentScore,
    };
  }

  Score.fromFirestore(Map<String, dynamic> firestore)
      : team = firestore['team'],
        opponent = firestore['opponent'],
        matchTime = firestore['matchTime'],
        teamScore = firestore['teamScore'],
        opponentScore = firestore['opponentScore'];
}

class FirestoreServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final songref = FirebaseFirestore.instance.collection('likedSongs');
   Future<void> savescore(Score score) {
   return _db.collection('Scores').doc(score.matchTime).set(score.toMap());
    
   }

 
 

Stream<List<Topstory>> getstories() {
    return _db.collection('TopStories').snapshots().map((snapshot) =>
        snapshot.docs.map((docs) => Topstory.fromFirestore(docs.data())).toList());
  }
  
}
