class PriceChangePercentage {
  final double usd;

  PriceChangePercentage({required this.usd});

  factory PriceChangePercentage.fromJson(Map<String, dynamic> json) {
    return PriceChangePercentage(usd: json["usd"]);
  }

  String formattedPriceChangePercentage() {
    return "${usd.toStringAsFixed(2).replaceAll("-", "")}%";
  }
}
