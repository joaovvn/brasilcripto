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
    final currentFavorites = storage.read("favorites");
    favorites = List<CryptoSearchResult>.from(
        currentFavorites.map((coin) => CryptoSearchResult.fromJson(coin)));
    favorites.add(this);
    storage.write(
        "favorites", favorites.map((favorite) => favorite.toJson()).toList());
  }

  @override
  void removeFavorite() {
    final storage = GetStorage();
    final currentFavorites = storage.read("favorites");
    List<CryptoSearchResult> favorites = List<CryptoSearchResult>.from(
        currentFavorites.map((coin) => CryptoSearchResult.fromJson(coin)));
    favorites.removeWhere((coin) => coin.id == id);
    storage.write(
        "favorites", favorites.map((favorite) => favorite.toJson()).toList());
  }

  @override
  bool verifyFavorite() {
    final storage = GetStorage();
    final currentFavorites = storage.read<List>("favorites");
    if (currentFavorites == null) {
      return false;
    }
    List<CryptoSearchResult> favorites = List<CryptoSearchResult>.from(
        currentFavorites.map((coin) => CryptoSearchResult.fromJson(coin)));

    if (favorites.any((coin) => coin.id == id)) {
      return true;
    }
    return false;
  }
}
