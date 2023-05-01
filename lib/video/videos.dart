import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rugby_mobile/video/playlist.dart';
import 'package:rugby_mobile/video/video.dart';
import 'package:rugby_mobile/video/youtube-video-row.dart';
import 'package:youtube_data_api/models/channel.dart';
import 'package:youtube_data_api/models/playlist.dart';
//import 'package:youtube_data_api/models/video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_data_api/youtube_data_api.dart';

//import 'package:flutter_dotenv/flutter_dotenv.dart' as dot_env;
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Videos extends StatefulWidget {
 final Playlist playlist;

  Videos({
    Key? key,
    required this.playlist,
  }):super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {


  List<Video> videos = [];

  @override
  void initState() {
    super.initState();

    fetchVideos();
  }
Future<void> fetchVideos() async {
  String url = 'https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&key=API_KEY&maxResults=50&playlistId=${widget.playlist.id}';

  var response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    setState(() {
      videos = jsonResponse['items'].map<Video>((item) {
        return Video.fromJson(item);
      }).toList();
    });
  } else {
    print('I should handle this error better: ${response.statusCode}.');
  }
}
  
  final List<String> buttonTexts = [
    'New Videos',
    'Previous Match',
    'Live Stream',
    'Replay Videos',
    'Trainings',
  ];
  @override
  Widget build(BuildContext context) {
   
      return Scaffold(
        appBar: AppBar(
          
          backgroundColor: Color.fromARGB(255, 2, 46, 85),
          title: Text('Videos'),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: buttonTexts
                    .map(
                      (text) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(text,style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),),
                        ),
                      ),
                    )
                    .toList(),
              )
            ))),
           body: 
            SafeArea(
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 50);
          },
          itemCount: videos.length,
          itemBuilder: (context, index) {
            return YouTubeVideoRow(video: videos[index], key: null,);
          }
      ),
    ),
           //player
      
    );
  }
}


// Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text("This example retrieves all the videos in a playlist by id"),
//           ),
//           Expanded(
//             child: Container(
//               child: ListView.builder(
//           itemCount: YoutubeVideos.length,
//           itemBuilder: ( context, int index) {
//            final video1 =YoutubeVideos[index];
           
//             return Card(
//       child: Container(
//         margin: EdgeInsets.symmetric(vertical: 7.0),
//         padding: EdgeInsets.all(12.0),
//         child: Row(
//           children: <Widget>[
//             Image.network(
//               YoutubeVideos[index].thumbnail['default']['url'],
//             ),
//             Padding(padding: EdgeInsets.only(right: 20.0)),
//             Expanded(
//                 child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         YoutubeVideos[index].title,
//                         softWrap: true,
//                         style: TextStyle(fontSize: 18.0),
//                       ),
//                       Padding(padding: EdgeInsets.only(bottom: 1.5)),
//                       Text(
//                         YoutubeVideos[index].channelTitle,
//                         softWrap: true,
//                       ),
//                       Padding(padding: EdgeInsets.only(bottom: 3.0)),
//                       Text(
//                         YoutubeVideos[index].url,
//                         softWrap: true,
//                       ),
//                     ]))
//           ],
//         ),
//       ),
//     );
            
//           }),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               RaisedButton(
//                   child: Text("<< Prev page",
//                     style: TextStyle(
//                         color: Colors.white
//                     ),
//                   ),
//                   color: Colors.blue,
//                   onPressed: () async{
//                    // ytResult = await ytApi.prevPage();
//                     // if(ytResult != null) {
//                     //   setState(() {});
//                     // }
//                   }
//               ),
//               RaisedButton(
//                   child: Text("Next page >>",
//                     style: TextStyle(
//                         color: Colors.white
//                     ),
//                   ),
//                   color: Colors.blue,
//                   onPressed: () async{
//                     // ytResult = await ytApi.nextPage();
//                     // if(ytResult != null) {
//                     //   setState(() {});
//                     // }
//                   }
//               ),
//             ],
//           )
//         ],
//       ),