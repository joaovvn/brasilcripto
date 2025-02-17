import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/features/home/view_model/home_view_model.dart';
import 'package:brasil_cripto/shared/models/search/crypto_search_result.dart';
import 'package:brasil_cripto/shared/widgets/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(
      {super.key, required this.crypto, required this.homeViewModel});

  final CryptoSearchResult crypto;
  final HomeViewModel homeViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => homeViewModel.openDetailsScreen(crypto.id),
      child: Row(
        spacing: 20,
        children: [
          SizedBox(
            height: 62.5,
            width: 62.5,
            child: Image.network(
              crypto.large,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.secondary,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              errorBuilder: (context, exception, stackTrace) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error,
                      color: Colors.white,
                      size: 25,
                    ),
                    Text(
                      "Not found",
                      style: TextStyle(fontSize: 8),
                    )
                  ],
                );
              },
              scale: 4.5,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  crypto.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  crypto.symbol,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary.withAlpha(150)),
                ),
              ],
            ),
          ),
          GetBuilder<HomeViewModel>(
              id: "item_${crypto.id}",
              builder: (context) {
                return FavoriteButton(
                  cryptoName: crypto.name,
                  onPressed: () => homeViewModel.removeAddFavorite(crypto),
                  isFavorite: crypto.verifyFavorite(),
                );
              }),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.secondary,
            size: 20,
          )
        ],
      ),
    );
  }
}
