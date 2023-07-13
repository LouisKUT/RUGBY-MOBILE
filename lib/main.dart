import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugby_mobile/authentication/widget_tree.dart';
import 'package:rugby_mobile/homepage/firestore/ScoresProvider.dart';
import 'package:rugby_mobile/homepage/firestore/TablesProvider.dart';
import 'package:rugby_mobile/homepage/firestore/Topstoriesprovider.dart';
import 'package:rugby_mobile/homepage/firestore/firestore_service.dart';
import 'package:rugby_mobile/homepage/firestore/predictionprovider.dart';
import 'package:rugby_mobile/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
        //TablesProvider
      
         ChangeNotifierProvider(create:(context) => storyProvider(),),
         ChangeNotifierProvider(create:(context) => scoresProvider(),),
         ChangeNotifierProvider(create:(context) => TablesProvider(),),
         ChangeNotifierProvider(create:(context) => PredictionsProvider(),),
      ],
      
      child: MaterialApp(
        title: 'My App',
        home: WidgetTree(),
        debugShowCheckedModeBanner: false,
       
        
      ),
    );
    
    
   
      
      
    
    // return MaterialApp(
    //   title: 'Flutter Demo',
    //   theme: ThemeData(
        
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: WidgetTree(),
    //   //home: HomeScreen(),
    // );
  }
}