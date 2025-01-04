import 'package:flutter/material.dart';

class home extends StatelessWidget {
  const home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'homepage',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  String selectedCategory = '';

  final Map<String, List<String>> recipesByCategory = {
    'Fried': ['Fried Chicken', 'Fried Rice'],
    'Steamed': ['Steamed Fish', 'Steamed Dumplings'],
    'Sauteed': ['Sauteed Vegetables', 'Garlic Sauteed Shrimp'],
    'Boiled': ['Boiled Eggs', 'Boiled Potatoes'],
    'Baked': ['Baked Cake', 'Baked Lasagna'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Resepkita'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade200, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Resep Terbaru
                SectionTitle(title: 'Resep Terbaru'),
                RecipeList(recipes: ['Resep 1', 'Resep 2', 'Resep 3']),

                SizedBox(height: 20),

                // Resep Terpopular
                SectionTitle(title: 'Resep Terpopular'),
                RecipeList(recipes: ['Resep A', 'Resep B', 'Resep C']),

                SizedBox(height: 20),

                // Pengkategorian Resep
                SectionTitle(title: 'Kategori Resep'),
                RecipeCategories(
                  categories: [
                    {'name': 'Fried', 'icon': Icons.local_fire_department},
                    {'name': 'Steamed', 'icon': Icons.cloud},
                    {'name': 'Sauteed', 'icon': Icons.kitchen},
                    {'name': 'Boiled', 'icon': Icons.water},
                    {'name': 'Baked', 'icon': Icons.cake},
                  ],
                  onCategorySelected: (category) {
                    setState(() {
                      selectedCategory = category;
                    });
                  },
                ),

                SizedBox(height: 20),

                // Resep Berdasarkan Kategori Terpilih
                if (selectedCategory.isNotEmpty) ...[
                  SectionTitle(title: 'Resep ${selectedCategory}'),
                  RecipeList(
                    recipes: recipesByCategory[selectedCategory] ?? [],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'homepage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'history',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'favorites',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.orange.shade800,
        ),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<String> recipes;

  const RecipeList({required this.recipes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            elevation: 4,
            child: Container(
              width: 120,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                gradient: LinearGradient(
                  colors: [Colors.orange.shade100, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Text(
                recipes[index],
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.orange.shade800,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecipeCategories extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final ValueChanged<String> onCategorySelected;

  const RecipeCategories({required this.categories, required this.onCategorySelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: categories.map((category) {
        return GestureDetector(
          onTap: () => onCategorySelected(category['name']),
          child: Chip(
            avatar: Icon(category['icon'], color: Colors.white),
            label: Text(
              category['name'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.orange.shade600,
            elevation: 4,
            shadowColor: Colors.orange.shade200,
          ),
        );
      }).toList(),
    );
  }
}
