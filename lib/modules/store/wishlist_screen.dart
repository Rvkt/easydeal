import 'package:easydeal/provider/cart_provider.dart';
import 'package:easydeal/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  void _removeFromWishlist(int index) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    List<Product> wishListProducts = productProvider.wishListProducts;
    final removedItem = wishListProducts.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: WishlistedItemWidget(
            product: removedItem,
            onRemove: () {
            },
            onAdd: () {},
          ),
        );
      },
    );
  }

  void _moveToCart(int index, Product product) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.removeFromWishlist(product);

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} moved to cart!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wishlist'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return provider.wishListProducts.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        size: 80,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your wishlist is empty!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : AnimatedList(
                  key: _listKey,
                  initialItemCount: provider.wishListProducts.length,
                  itemBuilder: (context, index, animation) {
                    if (index >= provider.wishListProducts.length) {
                      return const SizedBox.shrink(); // Return an empty widget if the index is out of bounds.
                    }
                    Product product = provider.wishListProducts[index];
                    return SizeTransition(
                      sizeFactor: animation,
                      child: WishlistedItemWidget(
                        product: product,
                        onRemove: () {
                          _removeFromWishlist(index);
                          provider.removeFromWishlist(product);
                        },
                        onAdd: () {
                          _moveToCart(index, product);
                        },
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}

class WishlistedItemWidget extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const WishlistedItemWidget({
    super.key,
    required this.product,
    required this.onRemove,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                product.image,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹ ${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                IconButton(
                  onPressed: onAdd,
                  icon: const Icon(Icons.shopping_cart_outlined),
                  tooltip: 'Move to Cart',
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: onRemove,
                  icon: const Icon(Icons.delete_outline),
                  tooltip: 'Remove',
                  color: Colors.red,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
