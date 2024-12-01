import 'package:flutter/material.dart';
import '../modules/store/models/cart_item_model.dart';
import '../modules/store/product.dart';



class CartProvider with ChangeNotifier {
  List<CartItem> _cartItems = [];
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
          quantity: 1,
        ),
      );

      double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
      int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);
      setTotalQuantity(totalQuantity);
      setTotalPrice(totalPrice);

    } else {
      // If the product is already in the cart, increase its quantity
      _cartItems[index].quantity++;
    }

    // Notify listeners to update the UI
    notifyListeners();
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
      double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
      int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);
      setTotalQuantity(totalQuantity);
      setTotalPrice(totalPrice);
    } else {
      double totalPrice = _cartItems.fold(0.0, (total, item) => total + (item.price * item.quantity));
      int totalQuantity = _cartItems.fold(0, (total, item) => total + item.quantity);
      setTotalQuantity(totalQuantity);
      setTotalPrice(totalPrice);
      _cartItems.removeAt(index);

    }
    notifyListeners();
  }
}
