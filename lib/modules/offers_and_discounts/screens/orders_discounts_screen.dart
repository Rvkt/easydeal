import 'package:flutter/material.dart';

import '../../../utils/utils.dart';
 import '../data/offer_local_data.dart';
import '../models/offer.dart';

class OrdersDiscountsScreen extends StatefulWidget {
  const OrdersDiscountsScreen({super.key});

  @override
  State<OrdersDiscountsScreen> createState() => _OrdersDiscountsScreenState();
}

class _OrdersDiscountsScreenState extends State<OrdersDiscountsScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        foregroundColor: Colors.black87,
        title: const Text('Offers and Discounts', style: TextStyle(
          fontSize: 16,
          color: Colors.black87,
          fontWeight: FontWeight.w600,
        ),),
      ),
      body: ListView.builder(
        itemCount:  offers.length,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(bottom: 16),
        itemBuilder: (context, index) {
          Offer offer = offers[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            clipBehavior: Clip.hardEdge,
            child: Container(
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
            ),
          );
        },
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
