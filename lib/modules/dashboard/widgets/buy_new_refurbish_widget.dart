import 'package:flutter/material.dart';

import '../../../core/theme/app_palette.dart';

class BuyNewRefurbishWidget extends StatefulWidget {
  const BuyNewRefurbishWidget({super.key});

  @override
  State<BuyNewRefurbishWidget> createState() => _BuyNewRefurbishWidgetState();
}

class _BuyNewRefurbishWidgetState extends State<BuyNewRefurbishWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(130, 52, 164, 246),
                    Color.fromARGB(130, 192, 224, 248),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12.0), // Match Card's border radius
              ),
              child: Card(
                color: Colors.transparent, // Make the card's background transparent
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/Buy.png',
                        width: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'BUY',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Brand New',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.black54),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppPalette.primaryColor, Color.fromRGBO(192, 229, 230, 1)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(12.0), // Match Card's border radius
              ),
              child: Card(
                color: Colors.transparent, // Make the card's background transparent
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/icons/Refurbish.png',
                        width: 48,
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'BUY',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Refurbish',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Icon(Icons.arrow_forward, color: Colors.black54),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}