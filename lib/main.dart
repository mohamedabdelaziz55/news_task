import 'package:flutter/material.dart';
import 'package:news_app_task/views/book_marks_view.dart';
import 'package:news_app_task/views/dashboard.dart';
import 'package:news_app_task/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';


 late SharedPreferences sp;
void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
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
        BookMarksView.id: (context) => BookMarksView(),
      },
    );
  }
}
