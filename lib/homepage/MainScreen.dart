import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rugby_mobile/dashboard/ScoresDashboard.dart';
import 'package:rugby_mobile/dashboard/models/NewsModel.dart';
import 'package:rugby_mobile/homepage/breaking_news_card.dart';
import 'package:rugby_mobile/homepage/news_list_tile.dart';
import 'package:rugby_mobile/homepage/news_model.dart';

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as Path;
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rugby_mobile/dashboard/inputtopstories.dart' ;
import 'package:rugby_mobile/homepage/breaking_news_card.dart';
import 'package:rugby_mobile/homepage/news_list_tile.dart';
import 'package:rugby_mobile/homepage/news_model.dart';
import 'package:rugby_mobile/pages/api/TeamData.dart';
import 'package:rugby_mobile/pages/api/remoteservices.dart';
//import 'package:rugby_mobile/pages/api/remoteservices.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rugby_mobile/authentication/auth.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? _currentUser;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  CollectionReference _newsCollection =
     FirebaseFirestore.instance.collection('TopStories');
  @override
  void initState() {
    super.initState();
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    User? user = _firebaseAuth.currentUser;
    setState(() {
      _currentUser = user;
    });
  }

  Future<void> _signOut() async {
    await Auth().signOut();
    setState(() {
      _currentUser = null;
    });
  }

  Widget _buildMenuBar(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.5, // Adjust the value as per your preference
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: _currentUser != null
                  ? Text('')
                  : Text(''),
              accountEmail: _currentUser != null
                  ? Text(_currentUser!.email ?? '')
                  : Text(''),
            ),
            TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardPage()),
    );
  },
  child: Text('News Dashboard'),
),
TextButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dashboardscores()),
    );
  },
  child: Text('Scores Dashboard'),
),
//DashboardPage
            ListTile(
              title: Text('Sign Out'),
              onTap: _signOut,
            ),
          ],
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RUGBY MOBILE'),
        actions: [
        //  Builder(
        //     builder: (BuildContext context) => IconButton(
        //       icon: Icon(Icons.menu),
        //       onPressed: () {
        //         Scaffold.of(context).openDrawer();
        //       },
        //    ),
        //  ),
          IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 5, 38, 66),
                Color.fromARGB(255, 2, 46, 85)
              ],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
        elevation: 20,
        titleSpacing: 20,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "News Feed",
                style: TextStyle(
                  fontSize: 26.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _newsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final breakingNewsData = snapshot.data!.docs;
                    return CarouselSlider.builder(
                      itemCount: breakingNewsData.length,
                      itemBuilder: (context, index, id) {
                        final doc = breakingNewsData[index];
                        final Newsdata = NewsData.fromSnapshot(doc);
                        return BreakingNewsCard(
                            
                                                                           
                            author: Newsdata.author.toString(), 
                            content: Newsdata.content.toString(), 
                            date: Newsdata.date.toString(), 
                            title: Newsdata.title.toString(), 
                            urlToImage: Newsdata.urlToImage.toString());
                      },

                      //
                      options: CarouselOptions(
                        aspectRatio: 16 / 9,
                        enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error fetching breaking news');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(
                height: 40.0,
              ),
              Text(
                "Top Stories",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 3.0,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('TopStories').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final recentNewsData = snapshot.data!.docs;
                    return Column(
                      children: recentNewsData
                          .map((snapshot) => NewsListTile(
                                NewsData.fromSnapshot(snapshot),
                              ))
                          .toList(),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error fetching recent news');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ],
          ),
        ),
      ),
      drawer: _buildMenuBar(context),
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

// // import 'dart:convert';
// // import 'package:carousel_slider/carousel_slider.dart';

// // import 'package:http/http.dart' as http;
// // import 'package:path/path.dart' as Path;
// // import 'package:flutter/src/foundation/key.dart';
// // import 'package:flutter/src/widgets/framework.dart';
// // import 'package:flutter/material.dart';
// // import 'package:rugby_mobile/dashboard/inputtopstories.dart';
// // import 'package:rugby_mobile/homepage/breaking_news_card.dart';
// // import 'package:rugby_mobile/homepage/news_list_tile.dart';
// // import 'package:rugby_mobile/homepage/news_model.dart';
// // import 'package:rugby_mobile/pages/api/TeamData.dart';
// // import 'package:rugby_mobile/pages/api/remoteservices.dart';
// // //import 'package:rugby_mobile/pages/api/remoteservices.dart';

// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:rugby_mobile/authentication/auth.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({Key? key}) : super(key: key);

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   User? _currentUser;
//final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //CollectionReference _newsCollection =
  //    FirebaseFirestore.instance.collection('TopStories');
//   @override
//   void initState() {
//     super.initState();
//     _getCurrentUser();
//   }

//   Future<void> _getCurrentUser() async {
//     User? user = _firebaseAuth.currentUser;
//     setState(() {
//       _currentUser = user;
//     });
//   }

//   Future<void> _signOut() async {
//     await Auth().signOut();
//     setState(() {
//       _currentUser = null;
//     });
//   }

//   Widget _buildMenuBar(BuildContext context) {
//     return FractionallySizedBox(
//       widthFactor: 0.5, // Adjust the value as per your preference
//       child: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             UserAccountsDrawerHeader(
//               accountName: _currentUser != null
//                   ? Text('')
//                   : Text(''),
//               accountEmail: _currentUser != null
//                   ? Text(_currentUser!.email ?? '')
//                   : Text(''),
//             ),
//             TextButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => DashboardPage()),
//     );
//   },
//   child: Text('Go to Dashboard'),
// ),

//             ListTile(
//               title: Text('Sign Out'),
//               onTap: _signOut,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('RUGBY MOBILE'),
// //         actions: [
// //          // Builder(
// //             //builder: (BuildContext context) => IconButton(
// //               // icon: Icon(Icons.menu),
// //               // onPressed: () {
// //               //   Scaffold.of(context).openDrawer();
// //               // },
// //            // ),
// //          // ),
// //           IconButton(
// //             icon: Icon(Icons.notifications_none),
// //             onPressed: () {},
// //           ),
// //           IconButton(
// //             icon: Icon(Icons.search),
// //             onPressed: () {},
// //           ),
// //         ],
// //         flexibleSpace: Container(
// //           decoration: BoxDecoration(
// //             gradient: LinearGradient(
// //               colors: [
// //                 Color.fromARGB(255, 5, 38, 66),
// //                 Color.fromARGB(255, 2, 46, 85)
// //               ],
// //               begin: Alignment.bottomRight,
// //               end: Alignment.topLeft,
// //             ),
// //           ),
// //         ),
// //         elevation: 20,
// //         titleSpacing: 20,
// //       ),
// //       body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.all(16),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "News Feed",
// //                 style: TextStyle(
// //                   fontSize: 26.0,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               //let's build our caroussel
// //               CarouselSlider.builder(
// //                   itemCount: NewsData.breakingNewsData.length,
// //                   itemBuilder: (context, index, id) =>
// //                       BreakingNewsCard(NewsData.breakingNewsData[index]),
// //                   options: CarouselOptions(
// //                     aspectRatio: 16 / 9,
// //                     enableInfiniteScroll: false,
// //                     enlargeCenterPage: true,
// //                   )),
// //               SizedBox(
// //                 height: 40.0,
// //               ),
// //               Text(
// //                 "Top Stories",
// //                 style: TextStyle(
// //                   fontSize: 26,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 3.0,
// //               ),
// //               //now let's create the cards for the recent news
// //               Column(
// //                 children: NewsData.recentNewsData
// //                     .map((e) => NewsListTile(e))
// //                     .toList(),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //       drawer: _buildMenuBar(context),
// //     );
// //   }
// // }

// // // class _MainScreenState extends State<MainScreen> {
// // // // String url = "Your_URL";

// // // //    Future<List<Fruit>> fetchFruit() async {
// // // // final response = await http.get(url);
// // // // }
// // //   Future<Post>? Teams;
// // //   var isLoaded = false;
// // //   @override
// // //   void initState() {
// // //     super.initState();

// // //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return DefaultTabController(
// //         length: 1,
// //         child: Scaffold(
// //             appBar: AppBar(
// //               title: Text('RUGBY MOBILE'),
// //               //centerTitle: true,
// //               leading: IconButton(
// //                 icon: Icon(Icons.menu),
// //                 onPressed: () {},
// //               ),
// //               actions: [
// //                 IconButton(
// //                   icon: Icon(Icons.notifications_none),
// //                   onPressed: () {},
// //                 ),
// //                 IconButton(
// //                   icon: Icon(Icons.search),
// //                   onPressed: () {},
// //                 )
// //               ],
// //               //backgroundColor: Colors.purple,
// //               flexibleSpace: Container(
// //                 decoration: BoxDecoration(
// //                   gradient: LinearGradient(
// //                     colors: [
// //                       Color.fromARGB(255, 5, 38, 66),
// //                       Color.fromARGB(255, 2, 46, 85)
// //                     ],
// //                     begin: Alignment.bottomRight,
// //                     end: Alignment.topLeft,
// //                   ),
// //                 ),
// //               ),
// //               // bottom: TabBar(
// //               //   //isScrollable: true,
// //               //   indicatorColor: Colors.white,
// //               //   indicatorWeight: 5,
// //               //   tabs: [
// //               //     Tab(
// //               //         child: GestureDetector(
// //               //       onTap: () {},
// //               //       child: Container(
// //               //         width: 200,
// //               //         height: 40,
// //               //         decoration: BoxDecoration(
// //               //           borderRadius: BorderRadius.circular(50),
// //               //           color: Color.fromARGB(255, 50, 89, 121),
// //               //         ),
// //               //         child: Center(
// //               //             child: Text(
// //               //           'Top Stories',
// //               //           style: TextStyle(
// //               //             fontSize: 15.0,
// //               //             fontWeight: FontWeight.bold,
// //               //             color: Colors.white,
// //               //           ),
// //               //         )),
// //               //       ),
// //               //     )),

// //               //   ],
// //               // ),
// //               elevation: 20,
// //               titleSpacing: 20,
// //             ),
// //             body: SingleChildScrollView(
// //         child: Padding(
// //           padding: EdgeInsets.all(16),
// //           child: Column(
// //             mainAxisAlignment: MainAxisAlignment.start,
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "News Feed",
// //                 style: TextStyle(
// //                   fontSize: 26.0,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 10,
// //               ),
// //               //let's build our caroussel
// //               CarouselSlider.builder(
// //                   itemCount: NewsData.breakingNewsData.length,
// //                   itemBuilder: (context, index, id) =>
// //                       BreakingNewsCard(NewsData.breakingNewsData[index]),
// //                   options: CarouselOptions(
// //                     aspectRatio: 16 / 9,
// //                     enableInfiniteScroll: false,
// //                     enlargeCenterPage: true,
// //                   )),
// //               SizedBox(
// //                 height: 40.0,
// //               ),
// //               Text(
// //                 "Top Stories",
// //                 style: TextStyle(
// //                   fontSize: 26,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               ),
// //               SizedBox(
// //                 height: 16.0,
// //               ),
// //               //now let's create the cards for the recent news
// //               Column(
// //                 children: NewsData.recentNewsData
// //                     .map((e) => NewsListTile(e))
// //                     .toList(),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),

// //             //  ListView.builder(
// //             //     itemCount: Teams?.length,
// //             //     itemBuilder: (context, index) {
// //             //       return Text(Teams![index].data.rugbyteams[index].rtName);
// //             //     }),
// //             ));
// //   }

// //   Widget setPage() {
// //     Color:
// //     Colors.red[800];

// //     return Stack(
// //       children: <Widget>[
// //         Container(
// //           // Background
// //           child: Center(
// //             child: Text(
// //               "Home",
// //               style: TextStyle(
// //                   fontSize: 25.0,
// //                   fontWeight: FontWeight.w600,
// //                   color: Colors.white),
// //             ),
// //           ),
// //           color: Colors.red[800],
// //           height: 50,
// //           width: 50,
// //         ),

// //         Container(), // Required some widget in between to float AppBar

// //         Positioned(
// //           // To take AppBar Size only
// //           top: 100.0,
// //           left: 20.0,
// //           right: 20.0,
// //           child: AppBar(
// //             backgroundColor: Colors.white,
// //             leading: Icon(
// //               Icons.menu,
// //               color: Colors.red[800],
// //             ),
// //             primary: false,
// //             title: TextField(
// //                 decoration: InputDecoration(
// //                     hintText: "Search",
// //                     border: InputBorder.none,
// //                     hintStyle: TextStyle(color: Colors.grey))),
// //             actions: <Widget>[
// //               IconButton(
// //                 icon: Icon(Icons.search, color: Colors.red[800]),
// //                 onPressed: () {},
// //               ),
// //               IconButton(
// //                 icon: Icon(Icons.notifications, color: Colors.red[800]),
// //                 onPressed: () {},
// //               )
// //             ],
// //           ),
// //         )
// //       ],
// //     );
// //   }

//   // void fetchUsers() async {
//   //   print('fetchUsers called');
//   //   const url = 'https://sports-info-api.onrender.com/v1/public/fixtures';
//   //   final uri = Uri.parse(url);
//   //   final Response = await http.get(uri);
//   //   final body = Response.body;
//   //   final json = jsonDecode(body);
//   //   setState((){
//   //   Teams = json['results'];
//   //   });
//   //   print('fetchUsers completed');
