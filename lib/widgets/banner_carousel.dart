import 'dart:async';
import 'package:banner_carousel/banner_carousel.dart';
import 'package:easydeal/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import '../utils/utils.dart'; // Assuming you are using a package like this for the carousel

class BannerCarouselWidget extends StatefulWidget {
  final List<BannerModel> imagesList;

  const BannerCarouselWidget({
    super.key,
    required this.imagesList,
  });

  @override
  _BannerCarouselWidgetState createState() => _BannerCarouselWidgetState();
}

class _BannerCarouselWidgetState extends State<BannerCarouselWidget> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < widget.imagesList.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double height = ScreenUtil.screenHeight;
    double width = ScreenUtil.screenWidth;

    bool isSmallDevice = height < 800;

    return Card(
      margin: const EdgeInsets.all(16),
      clipBehavior: Clip.hardEdge,
      child: BannerCarousel.fullScreen(
        pageController: _pageController,
        banners: widget.imagesList,
        customizedIndicators: const IndicatorModel.animation(
          width: 24,
          height: 4,
          spaceBetween: 2,
          widthAnimation: 50,
        ),
        height: height * 0.2,
        activeColor: AppPalette.primaryColor,
        disableColor: Colors.white,
        animation: true,
        borderRadius: 10,
        indicatorBottom: false,
      ),
    );
  }
}
