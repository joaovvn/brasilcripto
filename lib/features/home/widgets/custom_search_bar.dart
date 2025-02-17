import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 40;

  @override
  double get minExtent => 40;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  const CustomSearchBar({required this.onSubmitted, required this.controller});

  final Function() onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(10))),
        child: TextField(
          onSubmitted: (_) => onSubmitted(),
          controller: controller,
          textAlignVertical: TextAlignVertical.center,
          cursorColor: AppColors.secondary,
          decoration: InputDecoration(
              hintText: "Search crypto by name or symbol",
              isCollapsed: true,
              prefixIcon: Icon(
                Icons.search,
                color: AppColors.secondary,
              ),
              suffixIcon: controller.text.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        controller.clear();
                        onSubmitted();
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.secondary,
                      ))
                  : null,
              fillColor: AppColors.cryptoCard,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }
}
