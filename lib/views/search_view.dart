import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  List<String> news = [
    "Insurtech startup PasarPolis gets \$54 million — Series B",
    "Hypatos gets \$11.8M for a deep learning approach",
    "The IPO parade continues as Wish files, Bumble targets continues as parade",
    "Insurtech startup PasarPolis gets \$54 million — Series B",
    "Hypatos gets \$11.8M for a deep learning approach",
    "The IPO parade continues as Wish files, Bumble targets continues as parade",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            SizedBox(height: 60),
            Container(
              height: 70,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),

                color: Color(0xff141E28).withValues(alpha: .8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Virtual Reality",
                      style: TextStyle(color: Colors.white),
                    ),
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                      ),

                      child: Icon(Icons.search),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("13 Videos", style: TextStyle(fontSize: 24)),
                Icon(Icons.arrow_circle_right_outlined),
              ],
            ),

            SizedBox(
              height: 160,
              child: ListView.builder(
                itemCount: 14,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ListVideo();
                },
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("78 News", style: TextStyle(fontSize: 24)),
                Icon(Icons.arrow_circle_right_outlined),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: news.length,

                itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Text(news[index] ,style: TextStyle(fontSize: 16),),
                );
              },),
            )
          ],
        ),
      ),
    );
  }
}

class ListVideo extends StatelessWidget {
  const ListVideo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 140,
        width: 224,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/images/test.png")),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.play_circle_outline, color: Colors.white),
              SizedBox(height: 40),
              Text(
                "The IPO parade\n continues as Wish files",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
