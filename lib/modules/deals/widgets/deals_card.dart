import 'package:easydeal/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utils/utils.dart';
import '../../store/product.dart';

class DealsCard extends StatelessWidget {
  final Product product;

  const DealsCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    return Card(
      color: Colors.white,
      clipBehavior: Clip.hardEdge,
      shadowColor: Colors.black87,
      child: SizedBox(
        width: width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    product.image,
                    width: width * 0.6,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Expanded(
              child: Container(
                color: Colors.amber.shade200,
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                      '-${product.discount} off',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Spacer(),
                    Consumer<ProductProvider>(
                      builder: (context, provider, child) {
                        return InkWell(
                          onTap: () {
                            if(!provider.isFavorite(product)) {
                              provider.addToWishlist(product);
                            } else {
                              provider.removeFromWishlist(product);
                            }
                          },
                          child: Icon(
                            provider.isFavorite(product) ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
                            color: provider.isFavorite(product) ? Colors.red : Colors.grey.shade900,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
