import 'package:brasil_cripto/core/constants/app_images.dart';
import 'package:flutter/material.dart';

class CoinNotFound extends StatelessWidget {
  const CoinNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(AppImages.empty),
        Text(
          "Coin not found!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
