import 'history.dart';
import 'favorite.dart';
import 'package:flutter/material.dart';
import 'widgets/recipe_categories.dart';
//import 'widgets/recipe_list.dart';


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedCategory = '';
  List<String> history = []; // List untuk menyimpan data history
  final List<String> allRecipes = [
    'Picanha',
    'Yakimeshi',
    'Dorayaki',
    'Fried Chicken',
    'Fried Rice',
    'Steamed Fish',
    'Steamed Dumplings',
    'Sauteed Vegetables',
    'Garlic Sauteed Shrimp',
    'Boiled Eggs',
    'Boiled Potatoes',
    'Baked Cake',
    'Baked Lasagna',
  ];
  

  final Map<String, List<String>> recipesByCategory = {
    'Fried': ['Fried Chicken', 'Fried Rice'],
    'Steamed': ['Steamed Fish', 'Steamed Dumplings'],
    'Sauteed': ['Sauteed Vegetables', 'Garlic Sauteed Shrimp'],
    'Boiled': ['Boiled Eggs', 'Boiled Potatoes'],
    'Baked': ['Baked Cake', 'Baked Lasagna'],
  };

  int _selectedIndex = 0; // Track Which selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 1) {
      // Navigate To history Page with history data
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => History(recipeHistory: history),
        ),
      );
    } else if (index == 2) {
      // Navigate to favorite page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Favorite()),
      );
    }
  }

  void addToHistory(String recipeName) {
  setState(() {
    if (!history.contains(recipeName)) {
      history.insert(0, recipeName); // Tambahkan di awal untuk urutan terbaru
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resepkita'),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: RecipeSearchDelegate(allRecipes),
              );
            },
          ),
        ],
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
                const SectionTitle(title: 'Resep Terbaru'),
                RecipeList(
                  recipes: const ['Picanha', 'Yakimeshi', 'Dorayaki'],
                  onRecipeClick: addToHistory, // Tambahkan ke history
                ),

                const SizedBox(height: 20),

                // Resep Terpopular
                const SectionTitle(title: 'Resep Terpopular'),
                RecipeList(
                  recipes: const ['Resep A', 'Resep B', 'Resep C'],
                  onRecipeClick: addToHistory, // Tambahkan ke history
                ),

                const SizedBox(height: 20),

                // Pengkategorian Resep
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

                // Resep Berdasarkan Kategori Terpilih
                if (selectedCategory.isNotEmpty) ...[
                  SectionTitle(title: 'Resep $selectedCategory'),
                  RecipeList(
                    recipes: recipesByCategory[selectedCategory] ?? [],
                    onRecipeClick: addToHistory, // Tambahkan ke history
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
      // Bottom Navigation Bar
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
      padding: const EdgeInsets.only(bottom: 8.0),
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

class RecipeDetailPage extends StatelessWidget {
  final String recipeName;
  final String imageAssets;
  final String description;

  const RecipeDetailPage({
    super.key,
    required this.recipeName,
    required this.imageAssets,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipeName),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                imageAssets,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image, size: 100, color: Colors.grey);
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              recipeName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecipeList extends StatelessWidget {
  final List<String> recipes;
  final ValueChanged<String> onRecipeClick;

  const RecipeList({super.key, required this.recipes, required this.onRecipeClick});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              onRecipeClick(recipes[index]); // Panggil fungsi saat klik
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipeDetailPage(
                    recipeName: recipes[index],
                    imageAssets: 'assets/${recipes[index].toLowerCase().replaceAll(' ', '')}.jpeg',
                    description: 'Deskripsi lengkap untuk ${recipes[index]}.',
                  ),
                ),
              );
            },
            child: Card(
              margin: const EdgeInsets.symmetric(horizontal: 8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Container(
                width: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  gradient: LinearGradient(
                    colors: [Colors.orange.shade100, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/${recipes[index].toLowerCase().replaceAll(' ', '')}.jpeg',
                        width: 120,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.image, size: 50, color: Colors.grey);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      recipes[index],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class RecipeSearchDelegate extends SearchDelegate {
  final List<String> allRecipes;

  RecipeSearchDelegate(this.allRecipes);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search dialog
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = allRecipes
        .where((recipe) => recipe.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipeDetailPage(
                  recipeName: results[index],
                  imageAssets: 'assets/${results[index].toLowerCase().replaceAll(' ', '')}.jpeg',
                  description: 'Deskripsi lengkap untuk ${results[index]}.',
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = allRecipes
        .where((recipe) => recipe.toLowerCase().startsWith(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context);
          },
        );
      },
    );
  }
}
