import 'package:flutter/material.dart';
import '../constent.dart';
import '../widgets/category_card.dart';
import '../widgets/icons_appbar.dart';
import '../widgets/news_card.dart';

class BookMarksView extends StatefulWidget {
  const BookMarksView({super.key});
  static String id = 'BookMarks';

  @override
  State<BookMarksView> createState() => _BookMarksViewState();
}

class _BookMarksViewState extends State<BookMarksView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: const MenuIcon(),
        actions: const [IconsSearch(icon: Icons.search)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: bookmarkedCategories.length,
                  itemBuilder: (context, index) {
                    final cat = bookmarkedCategories[index];
                    return CategoryCard(
                      category: cat['category']!,
                      imagePath: cat['imagePath']!,
                      title: cat['title']!,
                      onRemove: () {
                        setState(() {
                          bookmarkedCategories.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "Latest bookmarks",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              if (bookmarkedArticles.isEmpty)
                const Center(child: Text("No bookmarks yet.😕"))
              else
                ...bookmarkedArticles.map(
                      (article) => Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: NewsCard(
                      article: article,
                      onDelete: () {
                        setState(() {
                          bookmarkedArticles.remove(article);
                        });
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
