import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constent.dart';

class NewsView extends StatefulWidget {
  static String id = "NewsView";

  const NewsView({super.key});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 380,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    image: DecorationImage(
                      image: AssetImage("assets/images/Mask.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Image.asset("assets/images/profile.png"),
                  SizedBox(width: 15),
                  Text("Samuel Newton", style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("TECHNOLOGY", style: TextStyle(color: customColor)),
                  SizedBox(height: 10),
                  Text(
                    "To build responsibly, tech needs to do more than just hire chief ethics officers",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  SizedBox(height: 20),
                  Text("17 June, 2023 — 4:49 PM"),
                  Divider(height: 70, indent: 20, endIndent: 20),
                  Text(
                    "In the last couple of years, we’ve seen new teams in tech companies emerge that focus on responsible innovation, digital well-being, AI ethics or humane use. Whatever their titles, these individuals are given the task of “leading” ethics at their companies.",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 100 , vertical: 40),
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
              buildNavIcon(CupertinoIcons.chat_bubble_text, 0),
              buildNavIcon(Icons.bookmark_border, 1),
              IconButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                icon: ImageIcon(
                  AssetImage('assets/icons/right.png'),
                  size: 24,
                  color: selectedIndex == 2 ? Colors.blue : Colors.black54,
                ),
              ),
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
        color: selectedIndex == index ? Colors.blue : Colors.black54,
      ),
      onPressed: () {
        setState(() {
          selectedIndex = index;
        });
      },
    );
  }
}
