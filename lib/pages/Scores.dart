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
    'Today',
    'Sunday',
    'Sarturday',
    'Friday',
    'Thursday',
    'Wednesday'
    'Tuesday'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 46, 85),
        title: Text('Scores '),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
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
            ),
          ),
        ),
      ),
      body: Container(
        child: Text('Scores will be displayed here.'),
      ),
    );
  }
}