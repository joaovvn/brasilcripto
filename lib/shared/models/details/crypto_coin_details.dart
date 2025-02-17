import "package:brasil_cripto/shared/models/crypto_coin_base.dart";
import "package:brasil_cripto/shared/models/details/crypto_coin_data.dart";
import "package:brasil_cripto/shared/models/details/crypto_coin_description.dart";
import "package:brasil_cripto/shared/models/details/crypto_coin_images.dart";
import "package:brasil_cripto/shared/models/search/crypto_search_result.dart";
import "package:get_storage/get_storage.dart";

class CryptoCoinDetails extends CryptoCoinBase {
  CryptoCoinImages images;
  CryptoCoinDescription description;
  CryptoCoinData data;
  CryptoCoinDetails(
      {required super.id,
      required super.name,
      required super.symbol,
      required this.images,
      required this.description,
      required this.data});

  factory CryptoCoinDetails.fromJson(Map<String, dynamic> json) {
    return CryptoCoinDetails(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"].toString().toUpperCase(),
        images: CryptoCoinImages.fromJson(json["image"]),
        description: CryptoCoinDescription.fromJson(json["description"]),
        data: CryptoCoinData.fromJson(json["market_data"]));
  }

  @override
  void addFavorite() {
    final storage = GetStorage();
    List<CryptoSearchResult> favorites;
    if (storage.read("favorites") == null) {
      favorites = [
        CryptoSearchResult(
            id: id,
            name: name,
            symbol: symbol,
            thumb: images.thumb,
            large: images.large)
      ];
      storage.write("favorites", favorites);
      return;
    }
    final currentFavorites = storage.read<List>("favorites");
    favorites = currentFavorites!
        .map((coin) => CryptoSearchResult.fromJson(coin))
        .toList();
    favorites.add(CryptoSearchResult(
        id: id,
        name: name,
        symbol: symbol,
        thumb: images.thumb,
        large: images.large));
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
