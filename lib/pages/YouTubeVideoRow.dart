import 'package:flutter/material.dart';

class SportsVideo {
  final String title;
  final String thumbnailUrl;
  final String duration;

  SportsVideo({
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
  });
}

class SportsVideosPage extends StatelessWidget {
  final List<SportsVideo> videos = [
    SportsVideo(
      title: 'Amazing Soccer Goals',
      thumbnailUrl: 'https://example.com/thumbnail1.jpg',
      duration: '10:23',
    ),
    SportsVideo(
      title: 'Basketball Highlights',
      thumbnailUrl: 'https://example.com/thumbnail2.jpg',
      duration: '5:45',
    ),
    SportsVideo(
      title: 'Best Tennis Moments',
      thumbnailUrl: 'https://example.com/thumbnail3.jpg',
      duration: '8:12',
    ),
    // Add more sports videos here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sports Videos'),
      ),
      body: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return ListTile(
            leading: Image.network(
              video.thumbnailUrl,
              width: 120,
              height: 90,
              fit: BoxFit.cover,
            ),
            title: Text(video.title),
            subtitle: Text(video.duration),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Handle video selection
            },
          );
        },
      ),
    );
  }
}
