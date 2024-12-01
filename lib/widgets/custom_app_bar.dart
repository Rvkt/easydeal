import 'package:easydeal/core/theme/app_palette.dart';
import 'package:easydeal/modules/store/cart_screen.dart';
import 'package:easydeal/modules/store/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../provider/location_provider.dart';
import '../utils/utils.dart';
import 'package:badges/badges.dart' as badges;

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(72); // add 60 when search field is visible.
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    _fetchPlacemark();
  }

  Future<void> _fetchPlacemark() async {
    final locationProvider = Provider.of<LocationProvider>(context, listen: false);
    locationProvider.getPlacemark();
  }

  @override
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    return Consumer<LocationProvider>(builder: (context, locationProvider, child) {
      Placemark? placemark = locationProvider.placemark;

      return AppBar(
        forceMaterialTransparency: true,
        title: Row(
          children: [
            const Icon(
              Icons.location_pin,
              color: Colors.black54,
            ),
            const SizedBox(width: 8),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery to',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (placemark != null)
                  Text(
                    '${placemark.postalCode}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                else
                  _location(context),
              ],
            ),
          ],
        ),
        actions: [
          // Search Icon
          IconButton(
            icon: Icon(_isSearching ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                _isSearching = !_isSearching; // Toggle search bar visibility
              });
            },
          ),
          if (!_isSearching) ...[
            // Favorite Icon
            IconButton(
              icon: const Icon(Icons.favorite_border),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen()));
              },
            ),


            // badges.Badge(
            //   badgeContent: const Text('3'),
            //   child: const Icon(Icons.shopping_cart),
            //   onTap: (){
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
            //   },
            // ),
            IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartScreen()));
              },
            ),
            const SizedBox(width: 8),
          ],
        ],
        bottom: _isSearching
            ? PreferredSize(
          preferredSize: const Size.fromHeight(48.0), // Height of the bottom widget
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: TextField(
              autofocus: true,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: Colors.black54),
                // border: UnderlineInputBorder(
                //   borderSide: BorderSide(color: Colors.black12),
                // ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppPalette.primaryColor), // You can change the color to anything you want
                ),
                prefixIcon: Icon(Icons.search, color: AppPalette.primaryColor),
              ),
              onSubmitted: (query) {
                // Handle the search query submission
                print('Search query: $query');
                setState(() {
                  _isSearching = false;
                });
              },
            ),
          )
          ,
        )
            : null,
      );
    });
  }


  Shimmer _location(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.25),
      highlightColor: AppPalette.primaryColor,
      child: const Text(
        'PINCODE',
        style: TextStyle(
          fontSize: 12,
          color: Colors.black54,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
