import 'package:flutter/material.dart';
import 'package:rugby_mobile/video/videos.dart';
import 'package:rugby_mobile/video/playlist.dart';


class PlaylistRow extends StatelessWidget {
  final Playlist playlist;

  const PlaylistRow({
    Key? key,
    required this.playlist
  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return Videos(playlist: playlist,);
          }),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 15.0, top: 10.0),
            child: Text(
              playlist.title,
              style: TextStyle(fontSize: 20.0),
            ),
          ),
          Image.network(playlist.image),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(playlist.description),
          ),
        ],
      ),
    );
  }
}