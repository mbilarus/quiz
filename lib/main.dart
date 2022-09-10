import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'quiz_app.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const QuizApp());
}

