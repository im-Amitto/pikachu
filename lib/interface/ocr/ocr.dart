import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pikachu/data/rest.dart';

class OCR extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OCRState();
}

class _OCRState extends State<OCR> {
  String _result;
  RestDatasource api = new RestDatasource();

  Future<void> _getAndScanImage() async {
    final File imageFile =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      api.ocr(imageFile).then((value) {
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
        title: const Text('OCR'),
      ),
      body: _result == null
          ? const Center(child: Text('No image selected.'))
          : Center(child: Text(_result)),
      floatingActionButton: FloatingActionButton(
        onPressed: _getAndScanImage,
        tooltip: 'Pick Image',
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
