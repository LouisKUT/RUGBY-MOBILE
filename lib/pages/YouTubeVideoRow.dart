import 'package:flutter/material.dart';
import 'package:rugby_mobile/video/video.dart';
//import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubeVideoRow extends StatefulWidget {
   final Video video;
  const YouTubeVideoRow({
    Key? key,
    required this.video
  }) : super(key: key);
  @override
  _YouTubeVideoRowState createState() => _YouTubeVideoRowState();
}

class _YouTubeVideoRowState extends State<YouTubeVideoRow> {

@override
void initState() {
  super.initState();

  _controller = YoutubePlayerController(
    initialVideoId: widget.video.id,
    flags: YoutubePlayerFlags(
      autoPlay: false,
      mute: false,
    ),
  );
}
late YoutubePlayerController _controller;
  
  
  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            player,
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Text(
                widget.video.title.toString(),
                style: TextStyle(
                  fontSize: 15.0,
                ),
              ),
            )
          ],
        );
      }
  );
  }
}