import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_task/views/news_view.dart';

import '../constent.dart';

class CategoryCard extends StatefulWidget {
  final String category;
  final String imagePath;
  final String title;
  final VoidCallback? onRemove;

  const CategoryCard({
    super.key,
    required this.category,
    required this.imagePath,
    required this.title,
    this.onRemove,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = bookmarkedCategories.any(
          (cat) => cat['category'] == widget.category,
    );
  }

  void handleBookmark() {
    if (!isBookmarked) {
      bookmarkedCategories.add({
        'category': widget.category,
        'imagePath': widget.imagePath,
        'title': widget.title,
      });

      setState(() {
        isBookmarked = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category "${widget.title}" added to bookmarks ✅'),
          duration: const Duration(seconds: 2),
        ),
      );
    } else {
      bookmarkedCategories.removeWhere(
            (cat) => cat['category'] == widget.category,
      );

      setState(() {
        isBookmarked = false;
      });

      widget.onRemove?.call(); // لإعادة بناء الصفحة الأم

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Category "${widget.title}" removed ❌'),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            NewsView.id,
            arguments: widget.category,
          );
        },
        child: Container(
          height: 320,
          width: 311,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  widget.imagePath,
                  height: 311,
                  width: 311,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                height: 311,
                width: 311,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: handleBookmark,
                          child: Icon(
                            isBookmarked
                                ? CupertinoIcons.bookmark_fill
                                : CupertinoIcons.bookmark,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/icons/right.png",
                          height: 24,
                          width: 24,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
