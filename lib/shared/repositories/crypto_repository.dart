import 'package:brasil_cripto/shared/models/details/crypto_coin_details.dart';
import 'package:brasil_cripto/shared/models/search/crypto_search_result.dart';
import 'package:brasil_cripto/shared/models/trending/trending_crypto_coin.dart';

abstract class CryptoRepository {
  Future<List<TrendingCryptoCoin>> getTrendingCryptos();
  Future<List<CryptoSearchResult>> searchCrypto(String query);
  Future<CryptoCoinDetails> getCryptoDetails(String coinId);
}
