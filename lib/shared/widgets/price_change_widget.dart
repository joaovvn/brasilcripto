import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class PriceChangeWidget extends StatelessWidget {
  const PriceChangeWidget(
      {super.key, required this.value, required this.formattedValue});

  final double value;
  final String formattedValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          value < 0 ? Icons.arrow_drop_down : Icons.arrow_drop_up,
          color: value < 0 ? AppColors.red : AppColors.green,
        ),
        Text(
          formattedValue,
          style: TextStyle(color: value < 0 ? AppColors.red : AppColors.green),
        ),
      ],
    );
  }
}
