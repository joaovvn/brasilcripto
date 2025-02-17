class CryptoCurrentPrice {
  final num usd;

  CryptoCurrentPrice({required this.usd});

  factory CryptoCurrentPrice.fromJson(Map<String, dynamic> json) {
    return CryptoCurrentPrice(usd: json["usd"]);
  }

  String formattedPrice() {
    return "\$ $usd";
  }
}
