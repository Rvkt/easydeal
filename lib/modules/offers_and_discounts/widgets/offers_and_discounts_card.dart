import 'package:easydeal/modules/offers_and_discounts/models/offer.dart';
import 'package:flutter/material.dart';

class OfferDiscountCard extends StatelessWidget {
  final Offer offer;

  const OfferDiscountCard({
    super.key,
    required this.offer,
  });

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
  }
}
