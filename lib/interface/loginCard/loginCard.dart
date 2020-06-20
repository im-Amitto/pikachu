import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikachu/data/rest.dart';

class LoginCard extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginCardState();
}

class _LoginCardState extends State<LoginCard> {
  String _result;
  RestDatasource api = new RestDatasource();

  Future<void> _getAndScanImage() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      api.loginCard(imageFile).then((value) {
        setState(() {
          _result = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Card'),
      ),
      body: _result == null
          ? const Center(child: Text('Upload a login card'))
          : Center(
              child: Text(_result,
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.cyan))),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAndScanImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
