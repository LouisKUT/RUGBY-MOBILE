import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rugby_mobile/authentication/SignIn.dart';
import 'package:rugby_mobile/authentication/auth.dart';
import 'package:rugby_mobile/authentication/homepage.dart';
import 'package:rugby_mobile/dashboard/TableDashboard.dart';
//import 'package:rugby_mobile/dashboard/inputtopstories.dart';
import 'package:rugby_mobile/pages/home.dart';
import 'package:rugby_mobile/pages/scores/scoresdata.dart';
import 'package:rugby_mobile/pages/tables/TableScreen.dart';

import '../dashboard/ScoresDashboard.dart';

class WidgetTree extends StatefulWidget {
   WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
    builder: (context, snapshot) {
      if(snapshot.hasData){
        //DashboardPage
        return LeagueTablePage();

        //HomeScreen();
      }else{
        return const LoginPage();
      }
      
    });
  }
}