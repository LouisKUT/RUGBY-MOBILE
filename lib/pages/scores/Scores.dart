import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
class Scores extends StatefulWidget {
  const Scores({Key? key}) : super(key: key);

  @override
  State<Scores> createState() => _ScoresState();
}

class _ScoresState extends State<Scores> {
  final List<String> buttonTexts = [
    'Scores',
    'Tables',
    'All Teams',
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 2, 46, 85),
          title: Text('Scores '),
          bottom: TabBar(tabs: [
    Tab(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Text(
                          'Scores',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    )),
    
                    Tab(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Text(
                          'Tables',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    )),
    Tab(
                        child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 200,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(0),
                          color: Colors.blue,
                        ),
                        child: Center(
                            child: Text(
                          'All Teams',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                      ),
                    )),
          ],)
    
          
        ),
        body: Container(
          child: Text('Scores will be displayed here.'),
        ),
      ),
    );
  }
}