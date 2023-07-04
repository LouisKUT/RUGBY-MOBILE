import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FixturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('fixtures').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final fixtures = snapshot.data!.docs;

        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Premier league",
                    style: TextStyle(
                      color: Colors.amber,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.amber,
                    size: 22,
                  ),
                ],
              ),
              SizedBox(height: 25),
              ListView.builder(
                shrinkWrap: true,
                itemCount: fixtures.length,
                itemBuilder: (BuildContext context, int index) {
                  final fixture = fixtures[index].data() as Map<String, dynamic>;

                  final time = fixture['time'];
                  final teamA = fixture['teamA'];
                  final teamALogoUrl = fixture['teamALogoUrl'];
                  final teamB = fixture['teamB'];
                  final teamBLogoUrl = fixture['teamBLogoUrl'];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          time,
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                teamA,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Image.network(
                                  teamALogoUrl,
                                  height: 38,
                                  width: 38,
                                ),
                              ),
                              Text(
                                " - ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Image.network(
                                  teamBLogoUrl,
                                  height: 38,
                                  width: 38,
                                ),
                              ),
                              Text(
                                teamB,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.notifications_none_rounded,
                          size: 26,
                          color: Colors.white60,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:rugby_mobile/pages/fixtures/LaLiga.dart';
// import 'package:rugby_mobile/pages/fixtures/PremierLeague.dart';
// import 'package:rugby_mobile/pages/fixtures/UEFA.dart';
// import 'package:rugby_mobile/pages/fixtures/fixturesData.dart';
// import 'package:rugby_mobile/pages/fixtures/remote.dart';
// import 'package:rugby_mobile/widgets/League2.dart';
// import 'package:rugby_mobile/widgets/League3.dart';
// import 'package:rugby_mobile/widgets/league1.dart';

// class FixtureScreen extends StatefulWidget {
//   const FixtureScreen({Key? key}) : super(key: key);

//   @override
//   State<FixtureScreen> createState() => _FixtureScreenState();
// }

// class _FixtureScreenState extends State<FixtureScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//         length: 6,
//         child: Scaffold(
//             backgroundColor: Color.fromARGB(255, 2, 46, 85),
//             appBar: AppBar(
//               backgroundColor: Color.fromARGB(255, 5, 38, 66),
//               bottom: PreferredSize(
//                 child: TabBar(
//                   isScrollable: true,
//                   unselectedLabelColor: Colors.white.withOpacity(0.7),
//                   indicatorColor: Colors.white,
//                   tabs: [
//                     const Tab(
//                       child: Text('17 May'),
//                     ),
//                     Tab(
//                       child: Text('18 May'),
//                     ),
//                     Tab(
//                       child: Text('19 May'),
//                     ),
//                     Tab(
//                       child: Text('Today'),
//                     ),
//                     Tab(
//                       child: Text('21 May'),
//                     ),
//                     Tab(
//                       child: Text('22 May'),
//                     ),
//                   ],
//                 ),
//                 preferredSize: Size.fromHeight(20.0),
//               ),
//             ),
//             body: FutureBuilder<Post>(
//                 future: RemoteService().getFixtures(),
//                 builder: (context, snapshot) {
//                   final results = snapshot.data;
//                   print("Fixtures result:" + results.toString());
//                   if (snapshot.hasData) {
                    
//                       return Container(
//                         //color: Colors.blueAccent,
//                         child: TabBarView(
//                           children: [
//                              ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                  final team = results!.data.fixtures[index];
//                       final hometeam = team.rFrpTidHomeTeam;
//                       final awayteam = team.rFrpTidAwayTeam;
//                       const hometeamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       const awayteamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       final matchtime = team.rFmatchTime;
//                 return Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 13.0,
//                                   right: 13.0,
//                                   bottom: 13.0,
//                                   top: 25),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     PremierLeague(
//                                       awayteam: awayteam.toString(),
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                     LaLiga(
//                                       awayteam: awayteam.toString(),
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//               },
//             ),

                      

//                               ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                  final team = results!.data.fixtures[index];
//                       final hometeam = team.rFrpTidHomeTeam;
//                       final awayteam = team.rFrpTidAwayTeam;
//                       const hometeamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       const awayteamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       final matchtime = team.rFmatchTime;
//                 return
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 13.0,
//                                   right: 13.0,
//                                   bottom: 13.0,
//                                   top: 25),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     PremierLeague(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                     LaLiga(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               );
//                   }),

//                     ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                  final team = results!.data.fixtures[index];
//                       final hometeam = team.rFrpTidHomeTeam;
//                       final awayteam = team.rFrpTidAwayTeam;
//                       const hometeamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       const awayteamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       final matchtime = team.rFmatchTime;
//                 return
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 13.0,
//                                   right: 13.0,
//                                   bottom: 13.0,
//                                   top: 25),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     PremierLeague(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                     LaLiga(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );  }),

//                                 ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                  final team = results!.data.fixtures[index];
//                       final hometeam = team.rFrpTidHomeTeam;
//                       final awayteam = team.rFrpTidAwayTeam;
//                       const hometeamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       const awayteamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       final matchtime = team.rFmatchTime;
//                 return
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 13.0,
//                                   right: 13.0,
//                                   bottom: 13.0,
//                                   top: 25),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     PremierLeague(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                     LaLiga(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                     UEFA(),
//                                   ],
//                                 ),
//                               ),
//                             );  }),
//                               ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                  final team = results!.data.fixtures[index];
//                       final hometeam = team.rFrpTidHomeTeam;
//                       final awayteam = team.rFrpTidAwayTeam;
//                       const hometeamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       const awayteamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       final matchtime = team.rFmatchTime;
//                 return
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 13.0,
//                                   right: 13.0,
//                                   bottom: 13.0,
//                                   top: 25),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     PremierLeague(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                      matchtime: matchtime.toString(),
//                                     ),
//                                     LaLiga(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                             }),
//                              ListView.builder(
//               itemCount: 10,
//               itemBuilder: (BuildContext context, int index) {
//                  final team = results!.data.fixtures[index];
//                       final hometeam = team.rFrpTidHomeTeam;
//                       final awayteam = team.rFrpTidAwayTeam;
//                       const hometeamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       const awayteamlogoUrl =
//                           "http://rugby.sportsinfoug.com/images/media/teams/teamlogo/defualut-Team-logo.png";
//                       final matchtime = team.rFmatchTime;
//                 return
//                             Padding(
//                               padding: const EdgeInsets.only(
//                                   left: 13.0,
//                                   right: 13.0,
//                                   bottom: 13.0,
//                                   top: 25),
//                               child: SingleChildScrollView(
//                                 child: Column(
//                                   children: [
//                                     PremierLeague(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                     LaLiga(
//                                       awayteam: awayteam,
//                                       hometeam: hometeam,
//                                       awayteamlogoUrl: awayteamlogoUrl,
//                                       hometeamlogoUrl: hometeamlogoUrl,
//                                       matchtime: matchtime.toString(),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                   }
//                   )],
//                         ),
//                       );
//                     }
//                    else if (snapshot.hasError) {
//                     return Text('${snapshot.error}');
//                   }

//                   // By default, show a loading spinner.
//                   return const Center(child: CircularProgressIndicator());
//                 })));
    //   } else if (snapshot.hasError) {
    //  return Text('${snapshot.error}');
    // }

    // By default, show a loading spinner.
    //   return const Center(child: CircularProgressIndicator());
    //  },
    //    )),
    //);
    //}
  

// SingleChildScrollView(
//           child: SizedBox(
//             height: 2000,
//             child: TabBarView(
//               children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
//                 child: Column(
//                     children: [
//                       League1(),
//                       League2(),
//                     ],
//                   ),
//               ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
//                   child: Column(
//                     children: [
//                       League2(),
//                       League1(),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
//                   child: Column(
//                     children: [
//                       League2(),
//                       League1(),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
//                   child: Column(
//                     children: [
//                       League1(),
//                       League2(),
//                       League3(),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
//                   child: Column(
//                     children: [
//                       League2(),
//                       League1(),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
//                   child: Column(
//                     children: [
//                       League2(),
//                       League1(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

  //   decoration: BoxDecoration(
  //     borderRadius: BorderRadius.all(Radius.circular(15)),
  //     color: Color.fromARGB(255, 2, 46, 85),
  //     // border: Border(

  //     //   right: BorderSide(
  //     //     color: Colors.black,
  //     //     width: 1.0,
  //     //   ),
  //     // ),
  //   ),
  //   child: Row(
  //     crossAxisAlignment: CrossAxisAlignment.start,

  //     children: [
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               SizedBox(height: 5.0),
  //               Text(
  //                 team.rFLocation,
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 10.0,
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               // Image.network(
  //               //   url,
  //               //   height: 50.0,
  //               //   width: 50.0,
  //               //   fit: BoxFit.contain,
  //               // ),
  //               // Image.file(pic),
  //               // Image.memory(team.rtTeamLogoUrl).image;
  //             ],
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               // Text(
  //               //   'Social Media Handles:',
  //               //   style: TextStyle(
  //               //     color: Colors.white,
  //               //     fontWeight: FontWeight.bold,
  //               //     fontSize: 14.0,
  //               //   ),
  //               // ),
  //               // SizedBox(height: 8.0),
  //               Text(
  //                 team.idRFixture,
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 10.0,
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               Text(
  //                 'Email:',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 14.0,
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               Text(
  //                 team.rFmatchTime.toString(),
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 10.0,
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               Text(
  //                 'Since:',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontWeight: FontWeight.bold,
  //                   fontSize: 10.0,
  //                 ),
  //               ),
  //               SizedBox(height: 5.0),
  //               Text(
  //                 team.rFrpTidAwayTeam,
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 14.0,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],

  //     // children: List.generate(
  //     //         results.data.rugbyteams.length,
  //     //         (index) => Text(
  //     //             results.data.rugbyteams[index].facebookUrl))
  //   ),
  // );
  //}
//}