import 'package:flutter/material.dart';
import 'package:gredit/screens/home.dart';
import 'package:gredit/screens/editor.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // builder: (context,child){
      //   return Scaffold(
      //     drawer: DashBoard(),
      //     body: child,
      //   );
      // },
      routes: {
        '/': (context) => Home(),
        EditorPage.routeName: (context) => EditorPage(),
        // ExtractArgsScreen.routeName: (context) => ExtractArgsScreen()
      },
    );
  }
}

// use
// blue for primary
// red for error
// green for success
// yellow for alert
