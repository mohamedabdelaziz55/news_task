import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constent.dart';
import '../storage_helper.dart';
import '../views/category_view.dart';

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
  DatabaseHelper db = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    checkIfBookmarked();
  }

  void checkIfBookmarked() async {
    List<Map<String, dynamic>> categories = await db.getCategories();
    bool bookmarked = categories.any(
          (cat) => cat['category'] == widget.category,
    );
    setState(() {
      isBookmarked = bookmarked;
    });
  }

  Future<void> AddCat() async {
    if (!isBookmarked) {
      final response = await db.insertCategory({
        'category': widget.category,
        'imagePath': widget.imagePath,
        'title': widget.title,
      });
      if (response > 0) {
        setState(() {
          isBookmarked = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category "${widget.title}" added to bookmarks ✅')),
        );
      }
    } else {
      await db.deleteCategory(widget.category);
      setState(() {
        isBookmarked = false;
      });
      widget.onRemove?.call();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Category "${widget.title}" removed ❌')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CategoryView(category: widget.category),
            ),
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
                child: CachedNetworkImage(
                  imageUrl: widget.imagePath,
                  fit: BoxFit.fill,
                  height: 311,
                  placeholder: (context, url) => const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
                          onTap: AddCat,
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
