import 'package:easydeal/data/deals_of_the_day.dart';
import 'package:easydeal/modules/store/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_palette.dart';
import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import '../../utils/utils.dart';

class ProductsScreen extends StatefulWidget {
  final String category;

  const ProductsScreen({
    super.key,
    required this.category,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  bool _isLoading = true;
  late List<String> _imagePaths;

  @override
  void initState() {
    super.initState();
    // Simulate a 2-second delay to show the circular progress indicator
    _imagePaths = []; // Initialize an empty list for image paths
    _loadImages();
  }

  Future<void> _loadImages() async {
    // Here we simulate a 2-second delay, you can customize how you handle the actual loading
    Future.delayed(const Duration(seconds: 2), () async {
      final provider = Provider.of<ProductProvider>(context, listen: false);
      // Get all image paths from the products
      _imagePaths = provider.products.where((product) => product.category == widget.category).map((product) => product.image).toList();

      // Pre-cache images
      for (var imagePath in _imagePaths) {
        await precacheImage(AssetImage(imagePath), context);
      }

      // Once images are loaded, update the UI to show the list
      setState(() {
        _isLoading = false;
      });
    });
  }

  void _moveToCart(int index, Product product) {
    final productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.removeFromWishlist(product);

    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.addToCart(product);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 300),
        content: Text('${product.name} moved to cart!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Consumer<ProductProvider>(
              builder: (context, provider, child) {
                List<Product> products = provider.products.where((product) => product.category == widget.category).toList();
                return products.isEmpty
                    ? const Center(
                        child: Text(
                          "No products available",
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      )
                    : ListView.builder(
                        itemCount: products.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          Product product = products[index];
                          return Card(
                            color: Colors.white,
                            clipBehavior: Clip.hardEdge,
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          product.image,
                                          width: MediaQuery.of(context).size.width,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          product.name,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // const SizedBox(height: 4),
                                Container(
                                  color: Colors.amber.shade200,
                                  padding: const EdgeInsets.all(8),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: 8),
                                      Text(
                                        '₹ ${product.price}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        '-${product.discount}% off',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      const Spacer(),
                                      // OutlinedButton(
                                      //   onPressed: () {
                                      //     _moveToCart(index, product);
                                      //   },
                                      //   style: OutlinedButton.styleFrom(
                                      //     backgroundColor: AppPalette.primaryColor,
                                      //     foregroundColor: Colors.white,
                                      //     side: const BorderSide(color: AppPalette.primaryColor, width: 2),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(8),
                                      //     ),
                                      //     padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      //   ),
                                      //   child: const Text(
                                      //     'Add To Cart',
                                      //     style: TextStyle(
                                      //       fontSize: 12,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),

                                      // OutlinedButton(
                                      //   onPressed: () {
                                      //     final cartProvider = Provider.of<CartProvider>(context, listen: false);
                                      //     if (!cartProvider.isInCart(product)) {
                                      //       cartProvider.addToCart(product); // Add the product to the cart
                                      //     }
                                      //   },
                                      //   style: OutlinedButton.styleFrom(
                                      //     backgroundColor: AppPalette.primaryColor,
                                      //     foregroundColor: Colors.white,
                                      //     side: const BorderSide(color: AppPalette.primaryColor, width: 2),
                                      //     shape: RoundedRectangleBorder(
                                      //       borderRadius: BorderRadius.circular(8),
                                      //     ),
                                      //     padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      //   ),
                                      //   child: Consumer<CartProvider>(
                                      //     builder: (context, cartProvider, child) {
                                      //       // Check if the product is already in the cart
                                      //       final isAdded = cartProvider.isInCart(product);
                                      //       return Text(
                                      //         isAdded ? 'Added' : 'Add To Cart',
                                      //         style: const TextStyle(
                                      //           fontSize: 12,
                                      //           fontWeight: FontWeight.bold,
                                      //         ),
                                      //       );
                                      //     },
                                      //   ),
                                      // ),

                                      Consumer<CartProvider>(
                                        builder: (context, cartProvider, child) {
                                          final isAdded = cartProvider.isInCart(product);

                                          if (isAdded) {
                                            // If the product is in the cart, show the quantity management UI
                                            final cartItem = cartProvider.getCartItem(product);
                                            return OutlinedButton(
                                              onPressed: () {
                                                // cartProvider.addToCart(product);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: AppPalette.accentColor,
                                                foregroundColor: Colors.white,
                                                side: const BorderSide(color: AppPalette.accentColor, width: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                              ),
                                              child: const Text(
                                                'Added To Cart',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          } else {
                                            // If the product is not in the cart, show the "Add To Cart" button
                                            return OutlinedButton(
                                              onPressed: () {
                                                cartProvider.addToCart(product);
                                              },
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor: AppPalette.primaryColor,
                                                foregroundColor: Colors.white,
                                                side: const BorderSide(color: AppPalette.primaryColor, width: 2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                              ),
                                              child: const Text(
                                                'Add To Cart',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),





                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              },
            ),
    );
  }
}
