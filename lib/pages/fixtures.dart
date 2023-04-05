import 'package:flutter/material.dart';
import 'package:rugby_mobile/widgets/League2.dart';
import 'package:rugby_mobile/widgets/League3.dart';
import 'package:rugby_mobile/widgets/league1.dart';

class FixtureScreen extends StatefulWidget {
  const FixtureScreen({Key? key}) : super(key: key);

  @override
  State<FixtureScreen> createState() => _FixtureScreenState();
}

class _FixtureScreenState extends State<FixtureScreen> {
  @override
  Widget build(BuildContext context) {
    
     return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 2, 46, 85),
          bottom: PreferredSize(
            child: TabBar(
              isScrollable: true,
              unselectedLabelColor: Colors.white.withOpacity(0.7),
              indicatorColor: Colors.white,
              tabs: [
                const Tab(
                  child: Text('17 May'),
                ),
                Tab(
                  child: Text('18 May'),
                ),
                Tab(
                  child: Text('19 May'),
                ),
                Tab(
                  child: Text('Today'),
                ),
                Tab(
                  child: Text('21 May'),
                ),
                Tab(
                  child: Text('22 May'),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(20.0),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: 2000,
            child: TabBarView(
              children: [
              Padding(
                padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
                child: Column(
                    children: [
                      League1(),
                      League2(),
                    ],
                  ),
              ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
                  child: Column(
                    children: [
                      League2(),
                      League1(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
                  child: Column(
                    children: [
                      League2(),
                      League1(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
                  child: Column(
                    children: [
                      League1(),
                      League2(),
                      League3(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
                  child: Column(
                    children: [
                      League2(),
                      League1(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 13.0, right: 13.0, bottom: 13.0, top: 25),
                  child: Column(
                    children: [
                      League2(),
                      League1(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
    );

  }
}