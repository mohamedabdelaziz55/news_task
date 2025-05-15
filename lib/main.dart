import 'package:flutter/material.dart';
import 'package:news_app_task/views/book_marks_view.dart';
import 'package:news_app_task/views/dashboard.dart';
import 'package:news_app_task/views/home_view.dart';
import 'package:news_app_task/views/news_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dashboard(),
      routes: {
        HomeView.id: (context) => HomeView(),
        NewsView.id: (context) => NewsView(),
        BookMarksView.id: (context) => BookMarksView(),
      },
    );
  }
}
