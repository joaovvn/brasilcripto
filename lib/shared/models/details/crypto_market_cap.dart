import 'package:brasil_cripto/core/utils/formatters.dart';

class CryptoMarketCap {
  final num usd;

  CryptoMarketCap({required this.usd});

  factory CryptoMarketCap.fromJson(Map<String, dynamic> json) {
    return CryptoMarketCap(usd: json["usd"]);
  }

  String formattedMarketCap() {
    return Formatters.formatCryptoPrice(usd);
  }
}
