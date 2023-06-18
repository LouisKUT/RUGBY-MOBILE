import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rugby_mobile/pages/api/TeamData.dart';
import 'package:rugby_mobile/pages/api/remoteservices.dart';
//import 'package:rugby_mobile/pages/api/remoteservices.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({Key? key}) : super(key: key);

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
// String url = "Your_URL";

//    Future<List<Fruit>> fetchFruit() async {
// final response = await http.get(url);
// }
  Future<Post>? Teams;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();

  }

final List<String> buttonTexts = [
    'Scores',
    'Tables',
    'All Teams',
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Post>(
          future: RemoteService().getTeamsData(),
          builder: (context, snapshot) {
            final results = snapshot.data;
            print("Teams results: "+results.toString());
            if (snapshot.hasData) {
              return 
                GridView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount: snapshot.data!.data.teams.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1
                      ,
                      childAspectRatio: 2.5,
                      crossAxisSpacing: 5.0,
                      mainAxisSpacing: 12.0,
                      
                    ),
                    
                    itemBuilder: (BuildContext context, int index) { 
                      final team =results!.data.teams[index];
                      //File pic =team.rtTeamLogoUrl as File;
                     // final picurl = team.rtTeamLogoUrl.toString();
                      const url = "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
                     // http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png
                      
                      return Container(
                         
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Color.fromARGB(255, 52, 59, 65), Color.fromARGB(255, 2, 46, 85)],
    ),
                          color: Color.fromARGB(255, 2, 46, 85),
                          // border: Border(
                            
                          //   right: BorderSide(
                          //     color: Colors.black,
                          //     width: 1.0,
                          //   ),
                          // ),
                        ),
                              child: Row(
                 crossAxisAlignment: CrossAxisAlignment.start,
              
              
                 children: [
                            Expanded(
                              child: Padding(
                 padding: const EdgeInsets.all(10.0),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                    SizedBox(height: 0.0),
                    Text(
                      team.rtName,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                SizedBox(height: 0.0),
                Padding(
  padding: EdgeInsets.all(14.0), // Adjust the value as per your requirement
  child: Image.asset('assets/images/logocrop.png',
                  height: 50,
                  width: 50.0,
                  //scale: 2.5,
                  // color: Color.fromARGB(255, 15, 147, 59),
                  opacity:
                      const AlwaysStoppedAnimation<double>(0.5)),
),
                
                    // Image.network(
                    //   //http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png
                    //   url,
                      
                    //   height: 50.0,
                    //   width: 50.0,
                    //   fit: BoxFit.contain,
                    // ),
                   // Image.file(pic),
                   // Image.memory(team.rtTeamLogoUrl).image;
                   
                  ],
                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Social Media Handles:',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 14.0,
                    //   ),
                    // ),
                    // SizedBox(height: 8.0),
                    Text(
                      team.rtAbbr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Email:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      team.districtId,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      'Since:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Text(
                      team.rtAbbr,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
                              ),
                            ),
                          ],
                               
              
              
                // children: List.generate(
                //         results.data.rugbyteams.length,
                //         (index) => Text(
                //             results.data.rugbyteams[index].facebookUrl))
                            
                            ), ); 
                    }
              );
            } 
            else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const Center(child: CircularProgressIndicator());
          },
        );

        //  ListView.builder(
        //     itemCount: Teams?.length,
        //     itemBuilder: (context, index) {
        //       return Text(Teams![index].data.rugbyteams[index].rtName);
        //     }),
        
  }

  Widget setPage() {
    Color:
    Colors.red[800];

    return Stack(
      children: <Widget>[
        Container(
          // Background
          child: Center(
            child: Text(
              "Home",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
          color: Colors.red[800],
          height: 50,
          width: 50,
        ),

        Container(), // Required some widget in between to float AppBar

        Positioned(
          // To take AppBar Size only
          top: 100.0,
          left: 20.0,
          right: 20.0,
          child: AppBar(
            backgroundColor: Colors.white,
            leading: Icon(
              Icons.menu,
              color: Colors.red[800],
            ),
            primary: false,
            title: TextField(
                decoration: InputDecoration(
                    hintText: "Search",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey))),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.search, color: Colors.red[800]),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.red[800]),
                onPressed: () {},
              )
            ],
          ),
        )
      ],
    );
  }

  // void fetchUsers() async {
  //   print('fetchUsers called');
  //   const url = 'https://sports-info-api.onrender.com/v1/public/fixtures';
  //   final uri = Uri.parse(url);
  //   final Response = await http.get(uri);
  //   final body = Response.body;
  //   final json = jsonDecode(body);
  //   setState((){
  //   Teams = json['results'];
  //   });
  //   print('fetchUsers completed');

}
