class CryptoSparkline {
  final List<double> price;

  CryptoSparkline({required this.price});

  factory CryptoSparkline.fromJson(Map<String, dynamic> json) {
    return CryptoSparkline(
        price:
            (json["price"] as List).map((value) => value as double).toList());
  }
}
