import 'package:flutter/material.dart';
import 'package:wishes/Views/Pages/home.dart';
import 'package:wishes/views/Pages/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Wishes',
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: Splash());
  }
}
