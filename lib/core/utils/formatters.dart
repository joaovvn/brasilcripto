import 'package:intl/intl.dart';

class Formatters {
  static String formatCryptoPrice(num price) {
    if (price >= 1) {
      return NumberFormat.currency(
              locale: 'en_US', symbol: '\$', decimalDigits: 2)
          .format(price);
    } else if (price >= 0.01) {
      return NumberFormat.currency(
              locale: 'en_US', symbol: '\$', decimalDigits: 4)
          .format(price);
    } else {
      String priceStr = price.toString();
      int firstNonZero =
          priceStr.indexOf(RegExp(r'[1-9]'), priceStr.indexOf('.') + 1);
      int decimals = firstNonZero - priceStr.indexOf('.') - 1;
      return NumberFormat.currency(
              locale: 'en_US', symbol: '\$', decimalDigits: decimals + 2)
          .format(price);
    }
  }
}
