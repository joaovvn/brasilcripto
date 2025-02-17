import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpErrorHandler {
  // Trata respostas HTTP
  static String handleHttpResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return 'Success!';
      case 400:
        return _extractMessage(response.body) ?? 'Bad request.';
      case 401:
        return 'Unauthorized: Authentication required.';
      case 403:
        return 'Forbidden: Access denied.';
      case 404:
        return 'Resource not found.';
      case 429:
        return 'Exceeded rate limit. Please try again later.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 503:
        return 'Service temporarily unavailable.';
      default:
        return 'Unknown error (status code: ${response.statusCode}).';
    }
  }

  // Trata exceções comuns
  static String handleException(dynamic error) {
    if (error.toString().isNotEmpty) {
      return error.toString();
    }

    if (error is SocketException) {
      return 'No internet connection.';
    }

    if (error is TimeoutException) {
      return 'Connection timeout. Please try again.';
    }

    if (error is FormatException) {
      return 'Error parsing the received data.';
    }

    return 'An unexpected error occurred.';
  }

  // Tenta extrair uma mensagem de erro do corpo da resposta
  static String? _extractMessage(String responseBody) {
    try {
      final decoded = json.decode(responseBody);
      if (decoded is Map<String, dynamic> && decoded.containsKey('error')) {
        return decoded['error'];
      }
    } catch (_) {
      // Ignora erro de parsing e retorna null
    }
    return null;
  }
}
