import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rugby_mobile/authentication/SignIn.dart';
import 'package:rugby_mobile/authentication/auth.dart';
import 'package:rugby_mobile/authentication/homepage.dart';
import 'package:rugby_mobile/pages/home.dart';

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
        return HomeScreen();
      }else{
        return const LoginPage();
      }
      
    });
  }
}