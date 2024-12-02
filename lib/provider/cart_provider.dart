import 'package:flutter/material.dart';
import '../modules/store/models/cart_item_model.dart';
import '../modules/store/product.dart';



class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  List<CartItem> get cartItems => _cartItems;

  int? _totalQuantity;
  int? get totalQuantity => _totalQuantity;

  setTotalQuantity(int? value) {
    _totalQuantity = value;
    notifyListeners();
  }

  double? _totalPrice;
  double? get totalPrice => _totalPrice;

  setTotalPrice(double? value) {
    _totalPrice = value;
    notifyListeners();
  }

  CartItem getCartItem(Product product) {
    return _cartItems.firstWhere((cartItem) => cartItem.id == product.id);
  }


  // Add an item to the cart
  void addToCart(Product product) {
    // Check if the product already exists in the cart
    int index = _cartItems.indexWhere((cartItem) => cartItem.id == product.id);

    if (index == -1) {
      // If the product is not in the cart, add it as a new CartItem with quantity = 1
      _cartItems.add(
        CartItem(
          id: product.id,
          name: product.name,
          price: product.price,
          image: product.image,
          discount: product.discount,
          category: product.category,
          quantity: 1,
        ),
      );

      // Update totals
      _updateCartTotals();

      // double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
      // int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);
      // setTotalQuantity(totalQuantity);
      // setTotalPrice(totalPrice);

    } else {
      // If the product is already in the cart, increase its quantity
      _cartItems[index].quantity++;
    }

    // Notify listeners to update the UI
    notifyListeners();
  }


  void _updateCartTotals() {
    double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
    int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);

    setTotalPrice(totalPrice);
    setTotalQuantity(totalQuantity);
  }

  bool isInCart(Product product) {
    return _cartItems.any((cartItem) => cartItem.id == product.id);
  }

  // Remove an item from the cart
  void removeFromCart(CartItem item) {
    _cartItems.remove(item);

    double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
    int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);
    setTotalQuantity(totalQuantity);
    setTotalPrice(totalPrice);

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    _totalPrice = 0.0;
    _totalQuantity = 0;

    notifyListeners();
  }

  // Increment quantity of a specific cart item
  void incrementQuantity(int index) {
    _cartItems[index].quantity++;

    double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
    int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);
    setTotalQuantity(totalQuantity);
    setTotalPrice(totalPrice);
    notifyListeners();
  }

  // Decrement quantity of a specific cart item
  void decrementQuantity(int index) {
    if (_cartItems[index].quantity > 1) {
      _cartItems[index].quantity--;
      // _updateCartTotals();
    } else {
      // _updateCartTotals();
      _cartItems.removeAt(index);

    }
    _updateCartTotals();
    notifyListeners();
  }
}
