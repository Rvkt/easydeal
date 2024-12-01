import '../product.dart';

class CartItem extends Product {
  int quantity;

  CartItem({
    required super.id,
    required super.name,
    required super.price,
    required super.image,
    required super.discount,
    this.quantity = 1,
  });
}