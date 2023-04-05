import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Videos extends StatefulWidget {
  const Videos({Key? key}) : super(key: key);

  @override
  State<Videos> createState() => _VideosState();
}

class _VideosState extends State<Videos> {
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
          ))));
  }
}