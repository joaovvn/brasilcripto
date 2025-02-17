import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/core/constants/app_images.dart';
import 'package:brasil_cripto/core/utils/custom_dialog.dart';
import 'package:flutter/material.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton(
      {super.key,
      required this.cryptoName,
      required this.onPressed,
      required this.isFavorite});

  final String cryptoName;
  final Function() onPressed;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () => isFavorite
            ? CustomDialog.showConfirmationDialog(
                "Do you want to remove $cryptoName from favorites?",
                () => onPressed())
            : onPressed(),
        icon: Image.asset(
          isFavorite ? AppImages.favoriteOn : AppImages.favoriteOff,
          color: isFavorite ? null : AppColors.secondary,
        ));
  }
}
