import 'package:flutter/material.dart';
import 'package:word_toob/dependency_inject.dart';
import 'package:word_toob/my_app.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await setup();
  runApp(const MyApp());
}


