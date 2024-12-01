import 'package:banner_carousel/banner_carousel.dart';
import 'package:easydeal/modules/dashboard/widgets/buy_new_refurbish_widget.dart';
import 'package:easydeal/modules/dashboard/widgets/offers_discounts.dart';
import 'package:easydeal/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/grid_item.dart';
import '../../utils/utils.dart';
import '../../widgets/banner_carousel.dart';
import '../../widgets/custom_app_bar.dart';
import '../../data/grid_items_data.dart';
import 'widgets/deals_of_the_day_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getProducts();
    });

  }

  getProducts() {
    Provider.of<ProductProvider>(context, listen: false).getProducts();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;

    double h1 = width * 0.075;
    double bodyText = width * 0.045;

    bool isSmallDevice = height < 800;
    bool isLargeDevice = height > 800;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(),
      body: ListView(
        children: [
          BannerCarouselWidget(
            imagesList: [
              BannerModel(
                imagePath: 'assets/images/img1.png',
                id: '1',
              ),
              BannerModel(
                imagePath: 'assets/images/img2.png',
                id: '2',
              ),
              BannerModel(
                imagePath: 'assets/images/img3.png',
                id: '3',
              ),
            ],
          ),
          const SizedBox(height: 16),
          // todo: Grid Items
          SizedBox(
            height: height * 0.225,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                // childAspectRatio: isSmallDevice ? 1 / 1.15 : 1 / 1.2,
              ),
              itemCount: items.length,
              // Use the length of the list
              itemBuilder: (context, index) {
                final GridItemData item = items[index]; // Get the item from the list
                return GridItem(gridItemData: item);
              },
            ),
          ),

          // todo: buy new or refurbished
          const BuyNewRefurbishWidget(),

          // todo: offers and discount
          const OffersAndDiscounts(),

          // todo: deal of the day
          const DealsOfTheDayWidget(),
        ],
      ),
    );
  }
}




