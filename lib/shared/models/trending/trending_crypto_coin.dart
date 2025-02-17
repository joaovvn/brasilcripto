import 'package:brasil_cripto/shared/models/trending/trending_crypto_item.dart';

class TrendingCryptoCoin {
  final TrendingCryptoItem item;

  TrendingCryptoCoin({required this.item});

  factory TrendingCryptoCoin.fromJson(Map<String, dynamic> json) {
    return TrendingCryptoCoin(
      item: TrendingCryptoItem.fromJson(json["item"]),
    );
  }
}
