import 'package:flutter/material.dart';
import 'package:pikachu/interface/about.dart';
import 'package:pikachu/interface/comingSoon.dart';
import 'package:pikachu/interface/loginCard/loginCard.dart';
import 'package:pikachu/interface/ocr/ocr.dart';
import 'package:pikachu/interface/ppg/ppg.dart';

final routes = {
'/ppg': (BuildContext context) => new PPG(),
'/comingSoon': (BuildContext context) => new ComingSoon(),
'/aboutUs': (BuildContext context) => new AboutUs(),
'/ocr': (BuildContext context) => new OCR(),
'/loginCard': (BuildContext context) => new LoginCard(),
};
