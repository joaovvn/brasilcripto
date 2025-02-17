import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PriceLabel extends StatelessWidget {
  const PriceLabel({super.key, required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      children: [
        Container(
          height: 12,
          width: 12,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
          ),
        )
      ],
    );
  }
}
