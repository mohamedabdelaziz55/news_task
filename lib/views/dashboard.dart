import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_task/views/search_view.dart';
import 'package:news_app_task/views/setting_screen.dart';
import 'book_marks_view.dart';
import 'home_view.dart';
import 'notifications_screen.dart';

class Dashboard extends StatefulWidget {
  static String id = "HomeView";

  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const BookMarksView(),
     SearchView(),
    NotificationsScreen(),
    const LanguageSwitchView(),
  ];

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      body: _pages[selectedIndex],
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(w * 0.05),
        child: Container(
          height: h * 0.08,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(h * 0.04),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildNavIcon(CupertinoIcons.home, 0, w),
              buildNavIcon(Icons.bookmark_border, 1, w),
              buildNavIcon(Icons.search, 2, w),
              buildNavIcon(Icons.notifications, 3, w),
              buildNavIcon(Icons.settings, 4, w),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNavIcon(IconData icon, int index, double w) {
    return IconButton(
      icon: Icon(
        icon,
        size: w * 0.07,
        color: selectedIndex == index
            ? Colors.black
            : Colors.black54.withAlpha(50),
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
