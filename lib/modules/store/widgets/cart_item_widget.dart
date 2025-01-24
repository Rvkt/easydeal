import 'package:flutter/material.dart';
import '../models/cart_item_model.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final VoidCallback onAdd;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                item.image,
                width: 88,
                height: 88,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                children: [
                  Text(
                    '${item.id}. ${item.name}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          '₹ ${(item.price).toStringAsFixed(2)}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                      Row(
                        children: [

                          const SizedBox(height: 4),
                          IconButton(
                            onPressed: onRemove,
                            icon: const Icon(Icons.remove),
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            onPressed: onAdd,
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
    );
  }
}
