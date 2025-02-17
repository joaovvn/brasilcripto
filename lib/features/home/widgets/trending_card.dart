import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/shared/models/trending/trending_crypto_item.dart';
import 'package:brasil_cripto/shared/widgets/price_change_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TrendingCard extends StatelessWidget {
  const TrendingCard(
      {super.key, required this.cryptoItem, required this.onTap});

  final TrendingCryptoItem cryptoItem;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: AppColors.cryptoCard,
              borderRadius: BorderRadius.circular(20)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 10,
                children: [
                  SizedBox(
                    height: 40,
                    width: 40,
                    child: Image.network(cryptoItem.thumb, scale: 1.6,
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
                    }, errorBuilder: (context, exception, stackTrace) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                            size: 20,
                          ),
                          Text(
                            "Not found",
                            style: TextStyle(fontSize: 8),
                          )
                        ],
                      );
                    }),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cryptoItem.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        cryptoItem.symbol,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.secondary.withAlpha(150)),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          cryptoItem.data.formattedPrice(),
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        PriceChangeWidget(
                            value: cryptoItem.data.priceChangePercentage24h.usd,
                            formattedValue: cryptoItem
                                .data.priceChangePercentage24h
                                .formattedPriceChangePercentage())
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("MARKET CAP",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary.withAlpha(150))),
                      Text(cryptoItem.data.marketCap,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary.withAlpha(150))),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 135,
                    child: SvgPicture.network(cryptoItem.data.sparkline,
                        placeholderBuilder: (_) => Center(
                              child: CircularProgressIndicator(
                                color: AppColors.secondary,
                              ),
                            ),
                        errorBuilder: (_, __, ___) => Text(
                              "Graph not available",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary.withAlpha(150)),
                            ),
                        colorFilter: const ColorFilter.mode(
                            AppColors.secondary, BlendMode.srcIn)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
