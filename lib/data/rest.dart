import 'dart:io';

import 'package:dio/dio.dart';

class RestDatasource {
  static final _baseUrl = "Server URL";
  Dio dio = new Dio();
  Future<String> ocr(File image) {
    FormData formData = new FormData.fromMap({"image": MultipartFile.fromFileSync(image.path)});
    return dio.post(_baseUrl + "/ocrImage", data: formData).then((res) {
      return res.data.toString();
    });
  }
  Future<String> loginCard(File image) {
    FormData formData = new FormData.fromMap({"image": MultipartFile.fromFileSync(image.path)});
    return dio.post(_baseUrl + "/loginCard", data: formData).then((res) {
      return res.data.toString();
    });
  }
}
