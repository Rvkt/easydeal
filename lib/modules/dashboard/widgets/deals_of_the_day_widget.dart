import 'package:easydeal/modules/deals/widgets/deals_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_palette.dart';
import '../../../provider/product_provider.dart';
import '../../../utils/utils.dart';
import '../../../data/deals_of_the_day.dart';
import '../../deals/deals_screen.dart';
import '../../store/product.dart';

class DealsOfTheDayWidget extends StatelessWidget {
  const DealsOfTheDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Deals of the day',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DealsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          // const SizedBox(height: 8),

          // Products Row
          Consumer<ProductProvider>(
            builder: (context, provider, child) {
              List<Product> products = provider.products;
              return SizedBox(
                height: height * 0.325,
                child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    Product product = products[index];
                    return DealsCard(product: product);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
