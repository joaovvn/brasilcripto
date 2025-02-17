import 'package:brasil_cripto/core/utils/formatters.dart';
import 'package:brasil_cripto/shared/models/details/crypto_current_price.dart';
import 'package:brasil_cripto/shared/models/details/crypto_market_cap.dart';
import 'package:brasil_cripto/shared/models/details/crypto_sparkline.dart';

class CryptoCoinData {
  final CryptoCurrentPrice price;
  final double priceChangePercentage7d;
  final CryptoMarketCap marketCap;
  final CryptoSparkline sparkline;

  CryptoCoinData({
    required this.price,
    required this.priceChangePercentage7d,
    required this.marketCap,
    required this.sparkline,
  });

  factory CryptoCoinData.fromJson(Map<String, dynamic> json) {
    return CryptoCoinData(
      price: CryptoCurrentPrice.fromJson(json["current_price"]),
      priceChangePercentage7d: json["price_change_percentage_7d"],
      marketCap: CryptoMarketCap.fromJson(json["market_cap"]),
      sparkline: CryptoSparkline.fromJson(json["sparkline_7d"]),
    );
  }

  String formattedPriceChangePercentage() {
    return "${priceChangePercentage7d.toStringAsFixed(2).replaceAll("-", "")}%";
  }

  String formattedPrice() {
    return Formatters.formatCryptoPrice(price.usd);
  }
}
