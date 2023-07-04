import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Video2Imp extends StatefulWidget {
  @override
  _Video2ImpState createState() => _Video2ImpState();
}

class _Video2ImpState extends State<Video2Imp> {
  List<DocumentSnapshot> _videos = [];

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  Future<void> _fetchVideos() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('videos').get();
    setState(() {
      _videos = snapshot.docs;
    });
  }

  @override
  void dispose() {
    super.dispose();
    for (final video in _videos) {
      final videoPlayerController =
          VideoPlayerController.network(video['url']);
      videoPlayerController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Match Highlights'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF000051), Color(0xFF0000A5)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: _videos.isNotEmpty
          ? ListView.builder(
              itemCount: _videos.length,
              itemBuilder: (BuildContext ctx, int index) {
                final videoUrl = _videos[index]['url'];
                final thumbnailUrl = _videos[index]['thumbnail'];
                final title = _videos[index]['title'];

                final videoPlayerController =
                    VideoPlayerController.network(videoUrl);
                final videoPlayerFuture = videoPlayerController.initialize();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: videoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Container(
                            height: 200, // Set the desired height
                            width: double.infinity,
                            child: _VideoPlayerWidget(
                              videoPlayerController: videoPlayerController,
                              thumbnailUrl: thumbnailUrl,
                            ),
                          );
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ],
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class _VideoPlayerWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final String thumbnailUrl;

  const _VideoPlayerWidget({
    required this.videoPlayerController,
    required this.thumbnailUrl,
  });

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<_VideoPlayerWidget> {
  late bool _showThumbnail;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _showThumbnail = true;
    _isLoading = false;
    widget.videoPlayerController.addListener(_videoPlayerListener);
  }

  void _videoPlayerListener() {
    if (widget.videoPlayerController.value.position ==
            widget.videoPlayerController.value.duration &&
        widget.videoPlayerController.value.isPlaying) {
      setState(() {
        _showThumbnail = true;
      });
    }
  }

  @override
  void dispose() {
    widget.videoPlayerController.removeListener(_videoPlayerListener);
    super.dispose();
  }

  void _togglePlay() {
    if (_showThumbnail) {
      setState(() {
        _showThumbnail = false;
        _isLoading = true;
      });
      widget.videoPlayerController.play().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    } else {
      setState(() {
        _showThumbnail = true;
      });
      widget.videoPlayerController.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _togglePlay,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: widget.videoPlayerController.value.aspectRatio,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _showThumbnail
                    ? AspectRatio(
                        aspectRatio: widget.videoPlayerController.value.aspectRatio,
                        child: Image.network(
                          widget.thumbnailUrl,
                          fit: BoxFit.cover,
                        ),
                      )
                    : VideoPlayer(widget.videoPlayerController),
                if (!_showThumbnail && !_isLoading)
                  VideoProgressIndicator(
                    widget.videoPlayerController,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                      playedColor: Colors.red,
                      bufferedColor: Colors.grey,
                    ),
                  ),
                if (!_showThumbnail && !_isLoading)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.videoPlayerController.value.position
                              .toString()
                              .split('.')[0],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          widget.videoPlayerController.value.duration
                              .toString()
                              .split('.')[0],
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          if (!_showThumbnail && _isLoading)
            CircularProgressIndicator(),
        ],
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class VideoStreamingPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Streaming'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('videos').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final videos = snapshot.data!.docs;

//             return ListView.builder(
//               itemCount: videos.length,
//               itemBuilder: (context, index) {
//                 final video = videos[index];
//                 final videoData = video.data() as Map<String, dynamic>;

//                 final videoUrl = videoData['url'];
//                 final videoTitle = videoData['title'];
//                 final videoLength = videoData['length'];

//                 return ListTile(
//                   title: Text(videoTitle),
//                   subtitle: Text(videoLength),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => VideoPlayerPage(videoUrl),
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }

// class VideoPlayerPage extends StatefulWidget {
//   final String videoUrl;

//   VideoPlayerPage(this.videoUrl);

//   @override
//   _VideoPlayerPageState createState() => _VideoPlayerPageState();
// }

// class _VideoPlayerPageState extends State<VideoPlayerPage> {
//   late YoutubePlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = YoutubePlayerController(
//       initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '',
//       flags: YoutubePlayerFlags(
//         autoPlay: true,
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Player'),
//       ),
//       body: Center(
//         child: YoutubePlayer(
//           controller: _controller,
//           showVideoProgressIndicator: true,
//           progressIndicatorColor: Colors.blueAccent,
//           onReady: () {
//             // Do something when the video is ready to play.
//           },
//         ),
//       ),
//     );
//   }
// }




// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:video_player/video_player.dart';

// class VideoStreamingPage extends StatefulWidget {
//   @override
//   _VideoStreamingPageState createState() => _VideoStreamingPageState();
// }

// class _VideoStreamingPageState extends State<VideoStreamingPage> {
//   late VideoPlayerController _videoPlayerController;

//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.network('');
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Video Streaming'),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance.collection('videos').snapshots(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             final videos = snapshot.data!.docs;

//             return ListView.builder(
//               itemCount: videos.length,
//               itemBuilder: (context, index) {
//                 final video = videos[index];
//                 final videoData = video.data() as Map<String, dynamic>;

//                 final videoUrl = videoData['url'];
//                 final videoTitle = videoData['title'];
//                 final videoLength = videoData['length'];

//                 return ListTile(
//                   title: Text(videoTitle),
//                   subtitle: Text(videoLength),
//                   onTap: () {
//                     _videoPlayerController = VideoPlayerController.network(videoUrl);
//                     _videoPlayerController.initialize().then((_) {
//                       setState(() {
//                         _videoPlayerController.play();
//                       });
//                     });
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) => AlertDialog(
//                         content: AspectRatio(
//                           aspectRatio: _videoPlayerController.value.aspectRatio,
//                           child: VideoPlayer(_videoPlayerController),
//                         ),
//                         actions: <Widget>[
//                           TextButton(
//                             child: const Text('Close'),
//                             onPressed: () {
//                               _videoPlayerController.pause();
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }






