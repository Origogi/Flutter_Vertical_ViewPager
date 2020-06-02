import 'package:flutter/material.dart';
import 'package:vertical_view_pager/vertical_card_pager.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Friz',
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: VerticalCardPager(),
        ),
      ),
    );
  }
}
