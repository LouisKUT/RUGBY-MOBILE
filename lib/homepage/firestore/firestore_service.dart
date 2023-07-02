import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rugby_mobile/homepage/firestore/Topstorymodel.dart';


class FirestoreServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final songref = FirebaseFirestore.instance.collection('likedSongs');
   Future<void> savestory(Topstory story) {
   return _db.collection('TopStories').doc(story.title).set(story.toMap());
    
   }

 
 

Stream<List<Topstory>> getstories() {
    return _db.collection('TopStories').snapshots().map((snapshot) =>
        snapshot.docs.map((docs) => Topstory.fromFirestore(docs.data())).toList());
  }
  
}
