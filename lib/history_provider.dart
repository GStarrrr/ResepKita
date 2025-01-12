//import 'package:coba/history.dart';
import 'package:flutter/material.dart';
//import 'homepage.dart';

class HistoryProvider with ChangeNotifier {
  final List<Map<String, String>> _history = [];
  final Map<String, List<Map<String, String>>> recipesByCategory;
  final List<Map<String, String>> recentRecipes;
  final Map<String, String> recipeDescriptions;

  HistoryProvider({
    required this.recipesByCategory,
    required this.recentRecipes,
    required this.recipeDescriptions,
  });

  List<Map<String, String>> get history => List.unmodifiable(_history);

  String _getShortDescription(String? fullDescription) {
    if (fullDescription == null) return 'Deskripsi Tidak Tersedia';
    final firstPart = fullDescription.split('Bahan-bahan:').first.trim();
    if (firstPart.length > 100) {
      return '${firstPart.substring(0, 97)}...';
    }
    return firstPart;
  }

  void addToHistory(Map<String, String> recipe) {
    // Memastikan image diambil dari recipesByCategory atau recentRecipes
    String imageAsset ='assets/default_food.jpg';
    
    // Mencari di recipesByCategory
    for (var category in recipesByCategory.values) {
      final found = category.firstWhere(
        (item) => item['name'] == recipe['name'],
        orElse: () => {},
      );
      if (found['image'] != null) {
        imageAsset = found['image']!;
        break;
      }
    }
    
    // Jika tidak ditemukan, cari di recentRecipes
    if (imageAsset == 'assets/default_food.jpg') {
      final found = recentRecipes.firstWhere(
        (item) => item['name'] == recipe['name'],
        orElse: () => {},
      );
      if (found['image']!= null) {
      imageAsset = found['image']!;
      }
    }

    final recipeDesc = recipeDescriptions[recipe['name']] ?? 'Deskripsi Tidak Tersedia';
    final historyItem = {
      'name': recipe['name'] ?? 'Resep Tanpa Nama',
      'image': imageAsset,
      'description': _getShortDescription(recipeDesc),
    };

    _history.add(historyItem);
    notifyListeners();
  }
}
