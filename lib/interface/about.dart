import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("About Us")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/loading.gif'),
              ),
              SizedBox(height: 20),
              Text(
                "Developed by",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.green,
                    fontStyle: FontStyle.italic),
              ),
              Text("Amey Kiran Patel",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black)),
              Text("Amit Kumar Meena",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black)),
              Text("Ghanshyam Bairwa",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black)),
              SizedBox(height: 20),
              Text(
                "Supervised by",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Colors.green,
                    fontStyle: FontStyle.italic),
              ),
              Text("Dr. Surya Prakash",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black)),
              Text("Vivek Singh Baghel",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 24,
                      color: Colors.black))
            ]),
      ),
    );
  }
}
