import 'package:flutter/material.dart';

import 'category_card.dart';

class ListViewCategory extends StatelessWidget {
  const ListViewCategory({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 320,
      child: ListView.builder(
        itemCount: 4,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryCard();
        },),
    );
  }
}

