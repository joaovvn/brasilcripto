import 'package:brasil_cripto/shared/models/crypto_coin_base.dart';
import 'package:brasil_cripto/shared/models/trending/trending_crypto_data.dart';

class TrendingCryptoItem extends CryptoCoinBase {
  final String thumb;
  final String large;
  final int coinId;
  final int marketCapRank;
  final String small;
  final String slug;
  final double priceBtc;
  final int score;
  final TrendingCryptoData data;

  TrendingCryptoItem({
    required super.id,
    required this.coinId,
    required super.name,
    required super.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.small,
    required this.large,
    required this.slug,
    required this.priceBtc,
    required this.score,
    required this.data,
  });

  factory TrendingCryptoItem.fromJson(Map<String, dynamic> json) {
    return TrendingCryptoItem(
      id: json["id"],
      coinId: json["coin_id"],
      name: json["name"],
      symbol: json["symbol"],
      marketCapRank: json["market_cap_rank"],
      thumb: json["thumb"],
      small: json["small"],
      large: json["large"],
      slug: json["slug"],
      priceBtc: (json["price_btc"] as num).toDouble(),
      score: json["score"],
      data: TrendingCryptoData.fromJson(json["data"]),
    );
  }
}
