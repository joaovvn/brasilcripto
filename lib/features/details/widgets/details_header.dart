import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/shared/models/details/crypto_coin_details.dart';
import 'package:flutter/material.dart';

class DetailsHeader extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 65;

  @override
  double get minExtent => 65;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  const DetailsHeader({required this.crypto});

  final CryptoCoinDetails crypto;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      color: AppColors.primary,
      child: Row(
        spacing: 10,
        children: [
          SizedBox(
              height: 50,
              width: 50,
              child: Image.network(
                crypto.images.small,
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
              )),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    crypto.name,
                    style: TextStyle(fontSize: 26),
                  ),
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
          Expanded(
            child: FittedBox(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("MARKET CAP",
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary.withAlpha(150))),
                  Text(crypto.data.marketCap.formattedMarketCap(),
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.secondary.withAlpha(150))),
                  Text(
                    crypto.data.formattedPrice(),
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
