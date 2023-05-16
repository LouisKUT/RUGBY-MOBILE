import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

class TableScreen extends StatefulWidget {
   String code;

   TableScreen({Key? key, required this.code}) : super(key: key);
  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  late List _table;
bool showButtonRow = true;
  getTable() async {
    http.Response response = await http.get(Uri.parse('http://api.football-data.org/v2/competitions/${widget.code}/standings')
        ,
        headers: {'X-Auth-Token': '86014f6025ae430dba078acc94bb2647'});
    String body = response.body;
    Map data = jsonDecode(body);
    List table = data['standings'][0]['table'];
    setState(() {
      _table = table;
    });
  }

  Widget buildTable() {
    List<Widget> teams = [];
    for (var team in _table) {
      teams.add(
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    team['position'].toString().length > 1
                        ? Text(team['position'].toString() + ' - ')
                        : Text(" " + team['position'].toString() + ' - '),
                    Row(
                      children: [
                        SvgPicture.network(
                          team['team']['crestUrl'],
                          height: 30,
                          width: 30,
                        ),
                        team['team']['name'].toString().length > 11
                            ? Text(team['team']['name']
                                    .toString()
                                    .substring(0, 11) +
                                '...')
                            : Text(team['team']['name'].toString()),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(team['playedGames'].toString()),
                    Text(team['won'].toString()),
                    Text(team['draw'].toString()),
                    Text(team['lost'].toString()),
                    Text(team['goalDifference'].toString()),
                    Text(team['points'].toString()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: teams,
    );
  }

  @override
  void initState() {
    super.initState();
    getTable();
  }

  @override
  Widget build(BuildContext context) {
    return _table == null
        ? Container(
            color: Colors.white,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xFFe70066),
                ),
              ),
            ),
          )
       : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.transparent,
                    pinned: true,
                    flexibleSpace: showButtonRow
                        ? Container(
                            height: 56.0,
                            color: Colors.grey[200],
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
       widget.code = "PL";
       getTable();
       buildTable();
    });
                                  },
                                  child: Text('Button 1'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
       widget.code = "PL";
       getTable();
       buildTable();
    });
                                  },
                                  child: Text('Button 2'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
      //_table = table;
       widget.code = "PL";
       getTable();
       buildTable();
    });
                                    // Perform action
                                  },
                                  child: Text('Button 3'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
      widget.code = "PL";
      getTable();
      buildTable();
    });
                                  },
                                  child: Text('Button 4'),
                                ),
                              ],
                            ),
                          )
                        : null,
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  Text(
                                    'Pos',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'Club',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'PL',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'W',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'D',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'L',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'GD',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Pts',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      buildTable(),
                    ]),
                  ),
                ],
              );
      
            
          
  }
}
