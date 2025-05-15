import 'package:flutter/material.dart';
import '../widgets/icons_appbar.dart';
import '../widgets/news_card.dart';

class BookMarksView extends StatelessWidget {
  static String id = 'BookMarks';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: ,
      appBar:AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: MenuIcon(),

        actions: [IconsSearch(icon: Icons.search)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Collections",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 120,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CategoryCard(title: 'SPORTS', image: 'https://picsum.photos/200/300?1'),
                    CategoryCard(title: 'TECH', image: 'https://picsum.photos/200/300?2'),
                    CategoryCard(title: 'SPORTS', image: 'https://picsum.photos/200/300?1'),
                    CategoryCard(title: 'TECH', image: 'https://picsum.photos/200/300?2'),

                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Latest bookmarks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...List.generate(
                10,
                    (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: NewsCard(onDelete: () {  },),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String title;
  final String image;

  const CategoryCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(image, width: 120, height: 120, fit: BoxFit.cover),
            Container(
              width: 120,
              height: 120,
              color: Colors.black.withOpacity(0.3),
              alignment: Alignment.center,
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
