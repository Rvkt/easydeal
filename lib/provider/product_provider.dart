import 'package:flutter/material.dart';

import '../data/deals_of_the_day.dart';
import '../data/sample_products.dart';
import '../modules/store/product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;

  List<Product> _wishListProducts = [];
  List<Product> get wishListProducts => _wishListProducts;

  setProducts(List<Product> products) {
    _products = products;
    notifyListeners();
  }

  getProducts() {
    setProducts(sampleProducts);
  }

  bool isFavorite(Product product) {
    return _wishListProducts.contains(product);
  }

  // Add product to wishlist
  void addToWishlist(Product product) {
    if (!_wishListProducts.contains(product)) {
      _wishListProducts.add(product);
      notifyListeners();
    }
  }

  // Remove product from wishlist
  void removeFromWishlist(Product product) {
    _wishListProducts.remove(product);
    notifyListeners();
  }
}