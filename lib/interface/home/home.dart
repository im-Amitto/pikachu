import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isCollapsed = true;
  double radius = 0;
  double screenHight, screenWidth;
  final Duration duration = const Duration(milliseconds: 300);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHight = size.height;
    screenWidth = size.width;
    return new Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xFFcb2d3e), Color(0xFFef473a)],
          ),
        ),
        child: Dashboard(context),
      ),
    );
  }

  Widget Dashboard(context) {
    return AnimatedPositioned(
      duration: duration,
      top: isCollapsed ? 0 : 0.075 * screenHight,
      bottom: isCollapsed ? 0 : 0.075 * screenWidth,
      left: isCollapsed ? 0 : 0.250 * screenWidth,
      right: isCollapsed ? 0 : -0.2 * screenWidth,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Container(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  AppBar(
                    leading: InkWell(
                        child: Icon(
                          Icons.info,
                        ),
                        onTap: () {
                          Navigator.of(context).pushNamed("/aboutUs");
                        }),
                    title: Text("Pikachu"),
                    centerTitle: true,
                  ),
                  Card(
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Core Tools",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Container(
                                height: 125.0,
                                child: new ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/ocr");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.airFreshener,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel: 'OCR',
                                                  ),
                                                  Text("OCR",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/ppg");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.heartbeat,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel: 'PPG',
                                                  ),
                                                  Text("PPG",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/comingSoon");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.userAlt,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel:
                                                        'Face detection',
                                                  ),
                                                  Text("Face detection",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/comingSoon");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.cat,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel:
                                                        'Image to Speech',
                                                  ),
                                                  Text("Image to Speech",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                  ],
                                ),
                              )
                            ],
                          ))),
                  Card(
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Derived tools",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Container(
                                height: 125.0,
                                child: new ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/loginCard");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.idCard,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel: 'Login Card',
                                                  ),
                                                  Text("Login Card",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/comingSoon");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.paintBrush,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel:
                                                        'Text Painter',
                                                  ),
                                                  Text("Text Painter",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                  ],
                                ),
                              )
                            ],
                          ))),
                  Card(
                      elevation: 5,
                      margin: EdgeInsets.fromLTRB(4.0, 10.0, 4.0, 10.0),
                      child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Medical Tools",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24)),
                              Container(
                                height: 125.0,
                                child: new ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: <Widget>[
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/comingSoon");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.userAlt,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel:
                                                        'Face Detection',
                                                  ),
                                                  Text("Face Detection",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                    Card(
                                        elevation: 5,
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamed("/comingSoon");
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Column(
                                                children: <Widget>[
                                                  FaIcon(
                                                    FontAwesomeIcons.heartbeat,
                                                    color: Colors.pink,
                                                    size: 70.0,
                                                    semanticLabel:
                                                        'PPG Reading',
                                                  ),
                                                  Text("PPG Reading",
                                                      style: TextStyle(
                                                          fontSize: 16)),
                                                ],
                                              ),
                                            ))),
                                  ],
                                ),
                              )
                            ],
                          ))),
                ]),
          ),
        ),
      ),
    );
  }
}
