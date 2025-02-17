import 'dart:convert';
import 'package:brasil_cripto/core/constants/api_urls.dart';
import 'package:brasil_cripto/core/utils/http_error_handler.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<dynamic>> fetchTrendingCryptos() async {
    try {
      final response = await http.get(Uri.parse(ApiUrls.trendingCryptos));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['coins'];
      } else {
        final warning = HttpErrorHandler.handleHttpResponse(response);
        throw Exception(warning);
      }
    } catch (e) {
      final errorMessage = HttpErrorHandler.handleException(e);
      throw Exception(errorMessage);
    }
  }

  Future<List<dynamic>> searchCrypto(String query) async {
    try {
      final response =
          await http.get(Uri.parse("${ApiUrls.searchCrypto}?query=$query"));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data['coins'];
      } else {
        final warning = HttpErrorHandler.handleHttpResponse(response);
        throw Exception(warning);
      }
    } catch (e) {
      final errorMessage = HttpErrorHandler.handleException(e);
      throw Exception(errorMessage);
    }
  }

  Future<Map<String, dynamic>> getCryptoData(String id) async {
    try {
      final response = await http.get(Uri.parse(
          "${ApiUrls.coinData}$id?localization=false&tickers=false&market_data=true&community_data=false&developer_data=false&sparkline=true"));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return data;
      } else {
        final warning = HttpErrorHandler.handleHttpResponse(response);
        throw Exception(warning);
      }
    } catch (e) {
      final errorMessage = HttpErrorHandler.handleException(e);
      throw Exception(errorMessage);
    }
  }
}
