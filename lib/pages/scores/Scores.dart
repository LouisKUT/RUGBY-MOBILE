import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:rugby_mobile/pages/scores/Teams.dart';
import 'package:rugby_mobile/pages/scores/predictions.dart';
import 'package:rugby_mobile/pages/scores/scoresdata.dart';
import 'package:rugby_mobile/pages/tables/HomeScreen.dart';
import 'package:rugby_mobile/pages/tables/TableScreen.dart';
class Scores extends StatefulWidget {
  const Scores({Key? key}) : super(key: key);

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
   int _selectedIndex = 0;
   String tablecode ='fj';
    bool showButtonRow = false;
    final RugbyMatchPredictionsPage predict= new RugbyMatchPredictionsPage();
     void initState() {
    
    // Call your method here
    //predict.sendInputData();
    
  }

  // ignore: prefer_final_fields
  List<Widget> _widgetOptions = <Widget>[
    
     
      RugbyMatchPredictionsPage(),
       RugbyScoresPage(),
       LeagueTablePage(),
       const TeamsScreen(),
   // Videos(),
   //Playlists(),
    //Scores(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 2, 46, 85),
          
          
        
        

           
           bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      _onItemTapped(0);
                      
                    },
                    child: const Text(
                      'Predictions',
                      style: TextStyle(color: Colors.white,fontSize:18),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  TextButton(
                    onPressed: () {
                    _onItemTapped(1);
                    },
                    child: const Text(
                      'Scores',
                      style: TextStyle(color: Colors.white,fontSize:18),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  TextButton(
                    onPressed: () {
                      _onItemTapped(2);
                       setState(() {
                  showButtonRow = !showButtonRow;
                });
                    },
                    child: const Text(
                      'Tables',
                      style: TextStyle(color: Colors.white,fontSize:18),
                    ),
                  ),
                  const SizedBox(width: 12.0),
                  TextButton(
                    onPressed: () {
                      _onItemTapped(3);
                    },
                    child: const Text(
                      'Teams',
                      style: TextStyle(color: Colors.white,fontSize:18),
                    ),
                  ),
                ],
                
              ),
            ),
          ),
        ),
        body: _widgetOptions.elementAt(_selectedIndex)
        ),
      );
  }
}