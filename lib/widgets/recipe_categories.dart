import 'package:flutter/material.dart';

class RecipeCategories extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final ValueChanged<String> onCategorySelected;

  const RecipeCategories({
    super.key,
    required this.categories,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            onTap: () {
              onCategorySelected(category['name']);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.orange.shade100,
                  child: Icon(category['icon'], color: Colors.orange.shade800),
                ),
                const SizedBox(height: 4),
                Text(
                  category['name'],
                  style: TextStyle(color: Colors.orange.shade800),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
