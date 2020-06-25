import 'package:flutter/material.dart';
import 'package:pikachu/interface/home/home.dart';
import 'package:pikachu/router.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pikachu',
      home: HomeScreen(),
      theme: new ThemeData(
          primarySwatch: Colors.blue,
          iconTheme:
              IconThemeData(color: Colors.green, opacity: 1, size: 20.0)),
      routes: routes,
    );
  }
}
