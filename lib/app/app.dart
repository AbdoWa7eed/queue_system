import 'package:flutter/material.dart';
import 'package:queue_system/utils/constants.dart';
import 'package:queue_system/views/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Queue Systems',
      theme: Constants.myTheme,
      home: const HomeView(),
    );
  }
}
