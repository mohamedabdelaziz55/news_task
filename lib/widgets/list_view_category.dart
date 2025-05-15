import 'package:flutter/material.dart';
import 'category_card.dart';

class CategoryListView extends StatelessWidget {
  CategoryListView({super.key});

  final List<Map<String, String>> categories = [
    {
      "category": "technology",
      "image": "https://images.unsplash.com/photo-1518773553398-650c184e0bb3?auto=format&fit=crop&w=800&q=80",
      "title": "Tech Innovations Today",
    },
    {
      "category": "business",
      "image": "https://images.unsplash.com/photo-1556740749-887f6717d7e4?auto=format&fit=crop&w=800&q=80",
      "title": "Business News Today",
    },
    {
      "category": "entertainment",
      "image": "https://images.unsplash.com/photo-1511671782779-c97d3d27a1d4?auto=format&fit=crop&w=800&q=80",
      "title": "Top Entertainment Stories",
    },
    {
      "category": "general",
      "image": "https://images.unsplash.com/photo-1504384308090-c894fdcc538d?auto=format&fit=crop&w=800&q=80",
      "title": "General Headlines",
    },
    {
      "category": "health",
      "image": "https://images.unsplash.com/photo-1526256262350-7da7584cf5eb?auto=format&fit=crop&w=800&q=80",
      "title": "Health Tips & Advice",
    },
    {
      "category": "science",
      "image": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzJ2hVzPMMtw-6RkipDHLNcL4V7LIft9_5Ew&s",
      "title": "Latest Scientific Research",
    },
    {
      "category": "sports",
      "image": "https://images.unsplash.com/photo-1517649763962-0c623066013b?auto=format&fit=crop&w=800&q=80",
      "title": "Sports Highlights",
    },

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("News Categories")),
      body: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final item = categories[index];
          return CategoryCard(
            category: item["category"]!,
            imagePath: item["image"]!,
            title: item["title"]!,
          );
        },
      ),
    );
  }
}
