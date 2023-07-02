import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDataPage extends StatefulWidget {
  @override
  _FirestoreDataPageState createState() => _FirestoreDataPageState();
}

class _FirestoreDataPageState extends State<FirestoreDataPage> {
  CollectionReference _newsCollection =
      FirebaseFirestore.instance.collection('TopStories');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firestore Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _newsCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final newsDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: newsDocs.length,
            itemBuilder: (context, index) {
              final doc = newsDocs[index];
              final newsData = NewsData.fromSnapshot(doc);

              return ListTile(
                title: Text(newsData.title ?? ''),
                subtitle: Text(newsData.author ?? ''),
                onTap: () {
                  // Navigate to the details page or perform an action
                },
              );
            },
          );
        },
      ),
    );
  }
}

class NewsData {
  String? title;
  String? author;
  String? content;
  String? urlToImage;
  String? date;

  NewsData({
    this.title,
    this.author,
    this.content,
    this.date,
    this.urlToImage,
  });

  factory NewsData.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return NewsData(
      title: data['title'] ?? '',
      author: data['author'] ?? '',
      content: data['content'] ?? '',
      date: data['date'] ?? '',
      urlToImage: data['urlToImage'] ?? '',
    );
  }
}
