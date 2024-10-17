import 'package:flutter/material.dart';

import 'package:flutter_test_task/home_page.dart';

void main() {
  runApp(const MyApp());
}

///
// ignore: prefer_match_file_name
class MyApp extends StatelessWidget {
  ///
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
