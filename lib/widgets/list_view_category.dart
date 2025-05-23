import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  CategoryListView({super.key});

  final List<Map<String, String>> categories = [
    {
      "category": "technology",
      "image": "https://images.unsplash.com/photo-1518773553398-650c184e0bb3?auto=format&fit=crop&w=800&q=80",
      "titleKey": "techTitle",
    },
    {
      "category": "business",
      "image": "https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=800&q=80",
      "titleKey": "businessTitle",
    },
    {
      "category": "entertainment",
      "image": "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80",
      "titleKey": "entertainmentTitle",
    },
    {
      "category": "general",
      "image": "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80",
      "titleKey": "generalTitle",
    },
    {
      "category": "health",
      "image": "https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?auto=format&fit=crop&w=800&q=80",
      "titleKey": "healthTitle",
    },
    {
      "category": "science",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzJ2hVzPMMtw-6RkipDHLNcL4V7LIft9_5Ew&s",
      "titleKey": "scienceTitle",
    },
    {
      "category": "sports",
      "image": "https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=800&q=80",
      "titleKey": "sportsTitle",
    },
  ];

  String getTranslatedTitle(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case "techTitle":
        return loc.techTitle;
      case "businessTitle":
        return loc.businessTitle;
      case "entertainmentTitle":
        return loc.entertainmentTitle;
      case "generalTitle":
        return loc.generalTitle;
      case "healthTitle":
        return loc.healthTitle;
      case "scienceTitle":
        return loc.scienceTitle;
      case "sportsTitle":
        return loc.sportsTitle;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    double cardHeight = screenHeight * 0.4;
    double cardWidth = screenWidth * 0.65;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.newsCategories),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final item = categories[index];
            return Padding(
              padding: EdgeInsets.only(
                left: index == 0 ? 16 : 8,
                right: index == categories.length - 1 ? 16 : 8,
              ),
              child: SizedBox(
                height: cardHeight,
                width: cardWidth,
                child: CategoryCard(
                  category: item["category"]!,
                  imagePath: item["image"]!,
                  title: getTranslatedTitle(context, item["titleKey"]!),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
