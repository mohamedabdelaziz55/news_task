import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app_task/views/news_view.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, NewsView.id);
        },
        child: Container(
          height: 320,
          width: 311,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(18)),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.asset(
                  "assets/images/Mask.png",
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "TECHNOLOGY",
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                        Text(
                          "3 min ago",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 100),
                    Text(
                      "Microsoft launches a deepfake detector tool ahead of US election",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.chat_bubble_text,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Icon(CupertinoIcons.bookmark, color: Colors.white),
                        Spacer(),
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
