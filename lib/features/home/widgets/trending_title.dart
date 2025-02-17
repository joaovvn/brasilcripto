import 'package:flutter/material.dart';

import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/core/constants/app_images.dart';

class TrendingTitle extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 95;

  @override
  double get minExtent => 95;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: AppColors.primary,
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Image.asset(AppImages.trending),
            Text("Trending Now!",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}
