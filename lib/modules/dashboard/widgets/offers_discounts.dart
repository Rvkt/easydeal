import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
import '../../offers_and_discounts/data/offer_local_data.dart';
import '../../offers_and_discounts/models/offer.dart';
import '../../offers_and_discounts/screens/orders_discounts_screen.dart';

class OffersAndDiscounts extends StatelessWidget {
  const OffersAndDiscounts({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Title and See All
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Offers & Discounts',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrdersDiscountsScreen(),
                    ),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          SizedBox(
            height: height * 0.12,
            child: ListView.builder(
              itemCount: offers.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                Offer offer = offers[index];
                return Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: _getColor(offer.colorName),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        _getIcon(offer.iconName),
                        color: Colors.blue,
                        size: 20,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        offer.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        offer.subtitle,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to get icon from name
  IconData _getIcon(String iconName) {
    switch (iconName) {
      case "info":
        return Icons.info;
      case "local_offer":
        return Icons.local_offer;
      default:
        return Icons.help_outline;
    }
  }

  // Helper method to get color from name
  Color _getColor(String colorName) {
    switch (colorName) {
      case "yellow100":
        return Colors.yellow.shade100;
      case "yellow200":
        return Colors.yellow.shade200;
      case "yellow300":
        return Colors.yellow.shade300;
      default:
        return Colors.grey.shade200;
    }
  }
}
