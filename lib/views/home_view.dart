import 'package:flutter/material.dart';
import '../widgets/icons_appbar.dart';
import '../widgets/list_view_category.dart';
import '../widgets/news_card.dart';

class HomeView extends StatelessWidget {
  static String id="HomeView";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: MenuIcon(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("News", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("App"),
          ],
        ),
        actions: [IconsSearch(icon: Icons.mic_none)],
      ),
      body: Column(
        children: [
          ListViewCategory(),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Latest News",
                  style: TextStyle(
                    color: Color(0xff111E29).withValues(alpha: 0.5),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_circle_right_outlined,
                    size: 18,
                    color: Color(0xff111E29).withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return NewsCard(onDelete: () {  },);
              },
            ),
          ),
        ],
      ),
    );
  }
}



class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {},
        ),
        actions: [IconButton(icon: Icon(Icons.notifications), onPressed: () {})],
      ),
      body: Center(child: Text("Notifications Page")),
    );
  }
}

