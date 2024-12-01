import 'dart:ui';

import 'package:easydeal/utils/utils.dart';
import 'package:flutter/material.dart';

import '../core/theme/app_palette.dart';

class GridItem extends StatelessWidget {
  final GridItemData gridItemData;

  const GridItem({
    super.key,
    required this.gridItemData,
    // required this.imagePath,
    // required this.label,
    // this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double width = ScreenUtil.screenWidth;
    double height = ScreenUtil.screenHeight;
    bool isSmallDevice = width < 400;

    return InkWell(
      onTap: gridItemData.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0), // Ensure the border radius is applied to the blur effect
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Adjust the blur effect
          child: Container(
            padding: const EdgeInsets.all(12),
            // color: Colors.white.withOpacity(1), // Fully opaque container to allow the blur effect to be visible
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    AppPalette.primaryColor,
                    BlendMode.srcATop,
                  ),
                  child: Image.asset(gridItemData.imagePath, width: isSmallDevice ? 30 : 36),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: Text(
                    gridItemData.label,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: TextStyle(
                      fontSize: isSmallDevice ? 10 : 12,
                      color: Colors.black54,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GridItemData {
  final String imagePath;
  final String label;
  final VoidCallback? onTap;

  GridItemData({
    required this.imagePath,
    required this.label,
    this.onTap,
  });
}
