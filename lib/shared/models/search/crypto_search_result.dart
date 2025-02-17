import 'package:brasil_cripto/shared/models/crypto_coin_base.dart';
import 'package:get_storage/get_storage.dart';

class CryptoSearchResult extends CryptoCoinBase {
  String thumb;
  String large;

  CryptoSearchResult(
      {required super.id,
      required super.name,
      required super.symbol,
      required this.thumb,
      required this.large});

  factory CryptoSearchResult.fromJson(Map<String, dynamic> json) {
    return CryptoSearchResult(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        thumb: json["thumb"],
        large: json["large"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'symbol': symbol,
      'thumb': thumb,
      'large': large,
    };
  }

  @override
  void addFavorite() {
    final storage = GetStorage();
    List<CryptoSearchResult> favorites;
    if (storage.read("favorites") == null) {
      favorites = [this];
      storage.write("favorites", favorites);
      return;
    }
    final currentFavorites = storage.read<List>("favorites");
    favorites = currentFavorites!
        .map((coin) => CryptoSearchResult.fromJson(coin))
        .toList();
    favorites.add(this);
    final newFavorites = favorites.map((coin) => coin.toJson()).toList();
    storage.write("favorites", newFavorites);
  }

  @override
  void removeFavorite() {
    final storage = GetStorage();
    final currentFavorites = storage.read<List>("favorites");
    List<CryptoSearchResult> favorites = currentFavorites!
        .map((coin) =>
            CryptoSearchResult.fromJson(Map<String, dynamic>.from(coin)))
        .toList();
    favorites.removeWhere((coin) => coin.id == id);
    final newFavorites = favorites.map((coin) => coin.toJson()).toList();
    storage.write("favorites", newFavorites);
  }

  @override
  bool verifyFavorite() {
    final storage = GetStorage();
    final currentFavorites = storage.read<List>("favorites");
    if (currentFavorites == null) {
      return false;
    }
    List<CryptoSearchResult> favorites = currentFavorites
        .map((coin) =>
            CryptoSearchResult.fromJson(Map<String, dynamic>.from(coin)))
        .toList();

    if (favorites.any((coin) => coin.id == id)) {
      return true;
    }
    return false;
  }
}
