import 'package:flutter/material.dart';
import 'history.dart'; // Import halaman history.dart
import 'favorite.dart'; // Import halaman favorite.dart

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedCategory = '';

  final Map<String, List<String>> recipesByCategory = {
    'Fried': ['Fried Chicken', 'Fried Rice'],
    'Steamed': ['Steamed Fish', 'Steamed Dumplings'],
    'Sauteed': ['Sauteed Vegetables', 'Garlic Sauteed Shrimp'],
    'Boiled': ['Boiled Eggs', 'Boiled Potatoes'],
    'Baked': ['Baked Cake', 'Baked Lasagna'],
  };

  int _selectedIndex = 0; // Track which index is selected

  // Handle Bottom Navigation Item Selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate to HistoryPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const history()),
      );
    } else if (index == 2) {
      // Navigate to FavoritePage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const favorite()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resepkita'),
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
                const SectionTitle(title: 'Resep Terbaru'),
                const RecipeList(recipes: ['Resep 1', 'Resep 2', 'Resep 3']),
                const SizedBox(height: 20),
                const SectionTitle(title: 'Resep Terpopular'),
                const RecipeList(recipes: ['Resep A', 'Resep B', 'Resep C']),
                const SizedBox(height: 20),
                const SectionTitle(title: 'Kategori Resep'),
                RecipeCategories(
                  categories: const [
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
                const SizedBox(height: 20),
                if (selectedCategory.isNotEmpty) ...[
                  SectionTitle(title: 'Resep $selectedCategory'),
                  RecipeList(
                    recipes: recipesByCategory[selectedCategory] ?? [],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Homepage',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

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

  const RecipeList({super.key, required this.recipes});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 8.0),
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

  const RecipeCategories({super.key, required this.categories, required this.onCategorySelected});

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
              style: const TextStyle(
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
