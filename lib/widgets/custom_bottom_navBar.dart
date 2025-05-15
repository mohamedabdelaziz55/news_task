import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35 , vertical: 12),
      child: Positioned(
        bottom: 16,
        left: 40,
        right: 40,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              Icon(Icons.home_outlined, size: 28, color: Colors.black54),
              Icon(Icons.bookmark_border, size: 28, color: Colors.black54),
              Icon(Icons.search, size: 28, color: Colors.black54),
              Icon(Icons.notifications_none, size: 28, color: Colors.black54),
              Icon(Icons.settings_outlined, size: 28, color: Colors.black54),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomBottomNavBar2 extends StatelessWidget {
  const CustomBottomNavBar2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35 , vertical: 12),
      child: Positioned(
        bottom: 16,
        left: 40,
        right: 40,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 12,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Icon(CupertinoIcons.chat_bubble_text, size: 28, color: Colors.black54),
              const Icon(Icons.bookmark_border, size: 28, color: Colors.black54),
              Image.asset(
                "assets/icons/right.png",
                height: 24,
                width: 24,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}