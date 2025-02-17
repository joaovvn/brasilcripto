abstract class CryptoCoinBase {
  final String id;
  final String name;
  final String symbol;

  CryptoCoinBase({
    required this.id,
    required this.name,
    required this.symbol,
  });

  bool verifyFavorite() {
    return false;
  }

  void addFavorite() {}

  void removeFavorite() {}
}
