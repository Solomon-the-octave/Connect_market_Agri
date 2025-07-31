class FavoritesManager {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Map<String, String>> _favoriteProducts = [];
  
  List<Map<String, String>> get favoriteProducts => List.unmodifiable(_favoriteProducts);
  
  bool isFavorite(Map<String, String> product) {
    return _favoriteProducts.any((p) => p['name'] == product['name']);
  }
  
  void addToFavorites(Map<String, String> product) {
    if (!isFavorite(product)) {
      _favoriteProducts.add(Map<String, String>.from(product));
    }
  }
  
  void removeFromFavorites(Map<String, String> product) {
    _favoriteProducts.removeWhere((p) => p['name'] == product['name']);
  }
  
  void toggleFavorite(Map<String, String> product) {
    if (isFavorite(product)) {
      removeFromFavorites(product);
    } else {
      addToFavorites(product);
    }
  }
  
  void clearFavorites() {
    _favoriteProducts.clear();
  }
}
