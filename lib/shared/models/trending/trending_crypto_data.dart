import 'package:brasil_cripto/core/utils/formatters.dart';
import 'package:brasil_cripto/shared/models/trending/price_change_percentage.dart';

class TrendingCryptoData {
  final double price;
  final String priceBtc;
  final PriceChangePercentage priceChangePercentage24h;
  final String marketCap;
  final String marketCapBtc;
  final String totalVolume;
  final String totalVolumeBtc;
  final String sparkline;

  TrendingCryptoData(
      {required this.price,
      required this.priceBtc,
      required this.priceChangePercentage24h,
      required this.marketCap,
      required this.marketCapBtc,
      required this.totalVolume,
      required this.totalVolumeBtc,
      required this.sparkline});

  factory TrendingCryptoData.fromJson(Map<String, dynamic> json) {
    return TrendingCryptoData(
        price: (json["price"] as num).toDouble(),
        priceBtc: json["price_btc"],
        priceChangePercentage24h:
            PriceChangePercentage.fromJson(json["price_change_percentage_24h"]),
        marketCap: json["market_cap"],
        marketCapBtc: json["market_cap_btc"],
        totalVolume: json["total_volume"],
        totalVolumeBtc: json["total_volume_btc"],
        sparkline: json["sparkline"]);
  }

  String formattedPrice() {
    return Formatters.formatCryptoPrice(price);
  }
}
