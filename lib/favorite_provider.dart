import 'package:flutter/foundation.dart';

class FavoriteProvider extends ChangeNotifier {
  final Set<String> _favorites = {};

  Set<String> get favorites => _favorites;

  bool toggleFavorite(String recipe) {
    if (_favorites.contains(recipe)) {
      _favorites.remove(recipe);
      notifyListeners();
      return false;
    } else {
      _favorites.add(recipe);
      notifyListeners();
      return true;
    }
  }

  bool isFavorite(String recipe) {
    return _favorites.contains(recipe);
  }
}