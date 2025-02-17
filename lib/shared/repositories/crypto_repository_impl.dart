import 'package:brasil_cripto/core/services/api_service.dart';
import 'package:brasil_cripto/shared/models/details/crypto_coin_details.dart';
import 'package:brasil_cripto/shared/models/search/crypto_search_result.dart';
import 'package:brasil_cripto/shared/models/trending/trending_crypto_coin.dart';
import 'package:brasil_cripto/shared/repositories/crypto_repository.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final ApiService _apiService;

  CryptoRepositoryImpl(this._apiService);

  @override
  Future<List<TrendingCryptoCoin>> getTrendingCryptos() async {
    try {
      final data = await _apiService.fetchTrendingCryptos();

      // Conversão dos dados em lista de CryptoCoin
      return data
          .map<TrendingCryptoCoin>((coin) => TrendingCryptoCoin.fromJson(coin))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CryptoSearchResult>> searchCrypto(String query) async {
    try {
      final data = await _apiService.searchCrypto(query);

      // Conversão dos dados em lista de CryptoCoin
      return data
          .map<CryptoSearchResult>((coin) => CryptoSearchResult.fromJson(coin))
          .toList();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<CryptoCoinDetails> getCryptoDetails(String coinId) async {
    try {
      final data = await _apiService.getCryptoData(coinId);

      // Conversão dos dados em lista de CryptoCoin
      return CryptoCoinDetails.fromJson(data);
    } catch (e) {
      throw Exception(e);
    }
  }
}
