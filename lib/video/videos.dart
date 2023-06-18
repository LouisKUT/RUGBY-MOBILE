import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SportsVideo {
  final String title;
  final String videoId;
  final String duration;

  SportsVideo({
    required this.title,
    required this.videoId,
    required this.duration,
  });
}

class SportsVideosPage extends StatefulWidget {
  @override
  _SportsVideosPageState createState() => _SportsVideosPageState();
}

class _SportsVideosPageState extends State<SportsVideosPage> {
  final List<SportsVideo> videos = [
    SportsVideo(
      title: 'Rugby Highlights 1',
      videoId: 'video_id_1',
      duration: '10:23',
    ),
    SportsVideo(
      title: 'Rugby Highlights 2',
      videoId: 'video_id_2',
      duration: '8:45',
    ),
    SportsVideo(
      title: 'Rugby Match Analysis',
      videoId: 'video_id_3',
      duration: '12:01',
    ),
    SportsVideo(
      title: 'Rugby Moments',
      videoId: 'video_id_4',
      duration: '9:57',
    ),
    SportsVideo(
      title: 'Rugby Tackling Techniques',
      videoId: 'video_id_5',
      duration: '7:32',
    ),
    SportsVideo(
      title: 'Rugby Try Compilation',
      videoId: 'video_id_6',
      duration: '11:48',
    ),
    SportsVideo(
      title: 'Rugby Training Drills',
      videoId: 'video_id_7',
      duration: '13:15',
    ),
    SportsVideo(
      title: 'Rugby Championship Highlights',
      videoId: 'video_id_8',
      duration: '15:27',
    ),
  ];

  late String selectedVideoId;

  @override
  void initState() {
    super.initState();
    selectedVideoId = videos[0].videoId; // Select the first video by default
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rugby Videos'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: selectedVideoId,
                flags: YoutubePlayerFlags(
                  autoPlay: true,
                  mute: false,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final video = videos[index];
                return ListTile(
                  leading: Icon(Icons.play_circle_outline),
                  title: Text(video.title),
                  subtitle: Text(video.duration),
                  onTap: () {
                    setState(() {
                      selectedVideoId = video.videoId;
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          setState(() {
            selectedVideoId = '';
          });
        },
        label: Text('Clear Selection'),
        icon: Icon(Icons.clear),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
