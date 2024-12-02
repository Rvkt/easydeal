import 'package:easydeal/core/theme/app_palette.dart';
import 'package:easydeal/modules/store/product.dart';
import 'package:easydeal/modules/store/widgets/cart_item_widget.dart';
import 'package:easydeal/provider/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/product_provider.dart';
import '../../utils/utils.dart';
import 'models/cart_item_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  void removeItem(int index) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    List<CartItem> cartItems = cartProvider.cartItems;
    final removedItem = cartItems.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: CartItemWidget(
            item: removedItem,
            onRemove: () {},
            onAdd: () {},
          ),
        );
      },
    );
  }

  void addQuantity(int index) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);

    // Increment the quantity using the provider
    cartProvider.incrementQuantity(index);

    // Trigger the animation or update the UI if necessary
    // If using AnimatedList or other animations, this may still be needed
    _listKey.currentState?.setState(() {
      // The UI should update automatically due to Provider
    });
  }


  void removeQuantity(int index) {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    List<CartItem> cartItems = cartProvider.cartItems;

    // Decrement the quantity using the provider
    cartProvider.decrementQuantity(index);

    _listKey.currentState?.setState(() {
      // Trigger the animation or update the UI if necessary
    });
  }

  void clearCart () {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.clearCart();

    _listKey.currentState?.setState(() {
      // Trigger the animation or update the UI if necessary
    });
  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Cart'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: Consumer<CartProvider>(
        builder: (context, provider, child) {
          return provider.cartItems.isEmpty
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
                        'Your Cart is empty!',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    ],
                  ),
                )
              : Column(
                children: [
                  Expanded(
                    child: AnimatedList(
                      key: _listKey,
                      initialItemCount: provider.cartItems.length,
                      itemBuilder: (context, index, animation) {
                        if (index >= provider.cartItems.length) {
                          return const SizedBox.shrink(); // Return an empty widget if the index is out of bounds.
                        }
                        CartItem product = provider.cartItems[index];
                        return CartItemWidget(
                          item: product,
                          onRemove: () {
                            removeQuantity(index);
                          },
                          onAdd: () {
                            addQuantity(index);
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹ ${provider.totalPrice}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.grey, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text(
                                  'Back',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Order placed!')),
                                  );
                                  clearCart();
                                },
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppPalette.primaryColor,
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: AppPalette.primaryColor, width: 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                child: const Text(
                                  'Place Order',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  
                ],
              );
        },
      ),

      // body: Column(
      //   children: [
      //     Expanded(
      //       child: AnimatedList(
      //         key: _listKey,
      //         initialItemCount: cartItems.length,
      //         itemBuilder: (context, index, animation) {
      //           final item = cartItems[index];
      //           return SizeTransition(
      //             sizeFactor: animation,
      //             child: CartItemWidget(
      //               item: item,
      //               onRemove: () {
      //                 setState(() {
      //                   if (item['quantity'] > 1) {
      //                     item['quantity']--;
      //                   } else {
      //                     removeItem(index);
      //                   }
      //                 });
      //               },
      //               onAdd: () {
      //                 setState(() {
      //                   item['quantity']++;
      //                 });
      //               },
      //             ),
      //           );
      //         },
      //       ),
      //     ),

        // ],
      // ),
    );
  }
}
