import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_task/views/search_view.dart';

import 'book_marks_view.dart';
import 'home_view.dart';

class Dashboard extends StatefulWidget {
  static String id = "HomeView";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    HomeView(),
    BookMarksView(),
    SearchView(),
    NotificationsPage(),
    SearchView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(25),
        child: Container(
          height: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavIcon(CupertinoIcons.home, 0),
              buildNavIcon(Icons.bookmark_border, 1),
              buildNavIcon(Icons.search, 2),
              buildNavIcon(Icons.notifications, 3),
              buildNavIcon(Icons.settings, 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavIcon(IconData icon, int index) {
    return IconButton(
      icon: Icon(
        icon,
        color:
        selectedIndex == index
            ? Colors.black
            : Colors.black54.withValues(alpha: 0.2),
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}