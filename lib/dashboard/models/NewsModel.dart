// import 'package:cloud_firestore/cloud_firestore.dart';

// class NewsModel {
//   final String title;
//   final String author;
//   final String content;
//   final String date;
//   final String urlToImage;

//   NewsModel({
//     required this.title,
//     required this.author,
//     required this.content,
//     required this.date,
//     required this.urlToImage,
//   });

//   factory NewsModel.fromSnapshot(DocumentSnapshot snapshot) {
//     final data = snapshot.data() as Map<String, dynamic>;
//     return NewsModel(
//       title: data['title'] ?? '',
//       author: data['author'] ?? '',
//       content: data['content'] ?? '',
//       date: data['date'] ?? '',
//       urlToImage: data['urlToImage'] ?? '',
//     );
//   }
// }


// class NewsData {
//   String? title;
//   String? author;
//   String? content;
//   String? urlToImage;
//   String? date;

//   NewsData({
//     this.title,
//     this.author,
//     this.content,
//     this.date,
//     this.urlToImage,
//   });

//   factory NewsData.fromSnapshot(DocumentSnapshot snapshot) {
//     Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
//     return NewsData(
//       title: data['title'] ?? '',
//       author: data['author'] ?? '',
//       content: data['content'] ?? '',
//       date: data['date'] ?? '',
//       urlToImage: data['urlToImage'] ?? '',
//     );
//   }
// }

