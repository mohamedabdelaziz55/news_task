
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
          child: Text(
            "🔕",
            style: TextStyle(
              fontSize: 80,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ),
    );
  }
}
