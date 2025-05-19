import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(12.0),
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
          height: h * 0.3,
          width: w * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 6,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: widget.imagePath,
                  fit: BoxFit.cover,
                  height: h * 0.3,
                  width: double.infinity,
                  placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
                ),
              ),
              Container(
                height: h * 0.3,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.035,
                  vertical: h * 0.015,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.category.toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.015,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: h * 0.008),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: Colors.white,
                          size: h * 0.025,
                        ),
                        SizedBox(width: w * 0.02),
                        GestureDetector(
                          onTap: AddCat,
                          child: Icon(
                            isBookmarked
                                ? CupertinoIcons.bookmark_fill
                                : CupertinoIcons.bookmark,
                            color: Colors.white,
                            size: h * 0.025,
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          "assets/icons/right.png",
                          height: h * 0.027,
                          width: h * 0.027,
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
