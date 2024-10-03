import 'package:flutter/material.dart';
import 'package:word_toob/dependency_inject.dart';
import 'package:word_toob/my_app.dart';

import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  runApp(const MyApp());
}






