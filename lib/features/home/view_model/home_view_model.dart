import 'dart:async';

import 'package:brasil_cripto/core/utils/app_connectivity.dart';
import 'package:brasil_cripto/core/utils/custom_snack_bar.dart';
import 'package:brasil_cripto/features/details/view/details_view.dart';
import 'package:brasil_cripto/shared/models/search/crypto_search_result.dart';
import 'package:brasil_cripto/shared/models/trending/trending_crypto_coin.dart';
import 'package:brasil_cripto/shared/repositories/crypto_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeViewModel extends GetxController {
  final CryptoRepositoryImpl _cryptoRepository = Get.find();

  RxList<TrendingCryptoCoin> trendingCryptos =
      List<TrendingCryptoCoin>.empty(growable: true).obs;
  RxList<CryptoSearchResult> cryptos =
      List<CryptoSearchResult>.empty(growable: true).obs;
  RxList<CryptoSearchResult> favorites =
      List<CryptoSearchResult>.empty(growable: true).obs;
  RxBool isLoading = false.obs;
  RxBool isOnline = true.obs;
  TextEditingController searchController = TextEditingController();
  TextEditingController favoritesSearchController = TextEditingController();
  RxInt bottomNavigationBarIndex = 0.obs;
  late Timer _timer;

  HomeViewModel();

  @override
  onInit() {
    AppConnectivity.listenConnectivity(isOnline);
    start();
    super.onInit();
  }

  @override
  void onClose() {
    _timer.cancel();
    super.onClose();
  }

  Future<void> start() async {
    if (isOnline.value) {
      getTrendingCryptos();
      _timer = Timer.periodic(
          Duration(minutes: 10), (_) => refreshTrendingCryptos());
    }
    // Caso a internet pare de funcionar o timer é cancelado, já quando volta ele atualiza os dados e volta o timer
    isOnline.listen((value) {
      if (value) {
        getTrendingCryptos();
        _timer = Timer.periodic(
            Duration(minutes: 10), (_) => refreshTrendingCryptos());
        return;
      }
      _timer.cancel();
    });
  }

  void onTapItem(int index) {
    bottomNavigationBarIndex.value = index;

    if (index == 1) {
      getFavorites();
      return;
    }
    if (cryptos.isEmpty) {
      getTrendingCryptos();
    }
  }

  Future<void> onRefresh({coinId = 0}) async {
    if (cryptos.isNotEmpty) {
      update(["item_$coinId"]);
      if (bottomNavigationBarIndex.value == 1) {
        getFavorites();
      }
      return;
    }

    getTrendingCryptos();
  }

  // Função para obter criptomoedas favoritadas
  void getFavorites() {
    isLoading.value = true;
    trendingCryptos.clear();
    final storage = GetStorage();
    final currentFavorites = storage.read<List>("favorites");
    if (currentFavorites == null) {
      isLoading.value = false;
      return;
    }
    favorites.value = currentFavorites
        .map((coin) =>
            CryptoSearchResult.fromJson(Map<String, dynamic>.from(coin)))
        .toList();
    filterFavorites();
    isLoading.value = false;
  }

  // Função para obter criptomoedas em alta
  Future<void> getTrendingCryptos() async {
    if (!isOnline.value) {
      return;
    }
    try {
      isLoading.value = true;
      cryptos.clear();
      searchController.clear();
      var result = await _cryptoRepository.getTrendingCryptos();
      trendingCryptos.value = result;
    } catch (e) {
      CustomSnackBar.throwErrorSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Função para atualizar criptomoedas em alta a cada 10 minutos (Informação da documentação -> Cache / Update Frequency: every 10 minutes for all the API plans)
  Future<void> refreshTrendingCryptos() async {
    if (!isOnline.value) {
      return;
    }
    if (cryptos.isNotEmpty) {
      return;
    }
    try {
      var result = await _cryptoRepository.getTrendingCryptos();
      trendingCryptos.value = result;
    } catch (e) {
      CustomSnackBar.throwErrorSnackBar(e.toString());
    }
  }

  Future<void> filterFavorites() async {
    favorites.value = favorites
        .where((coin) =>
            coin.name
                .toLowerCase()
                .contains(favoritesSearchController.text.toLowerCase()) ||
            coin.symbol
                .toLowerCase()
                .contains(favoritesSearchController.text.toLowerCase()))
        .toList();
  }

  // Função para buscar criptomoeda por nome ou simbolo
  Future<void> searchCrypto() async {
    if (bottomNavigationBarIndex.value == 1) {
      return getFavorites();
    }
    if (!isOnline.value) {
      searchController.clear();
      return;
    }
    if (searchController.text.isEmpty) {
      return getTrendingCryptos();
    }
    try {
      isLoading.value = true;
      var result = await _cryptoRepository.searchCrypto(searchController.text);
      cryptos = result.obs;
      trendingCryptos.clear();
    } catch (e) {
      searchController.clear();
      CustomSnackBar.throwErrorSnackBar(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> openDetailsScreen(String id) async {
    if (!isOnline.value) {
      return;
    }
    Get.to(() => DetailsView(coinId: id))?.then((_) => onRefresh(coinId: id));
  }

  void removeAddFavorite(CryptoSearchResult coin) {
    if (coin.verifyFavorite()) {
      coin.removeFavorite();
      update(["item_${coin.id}"]);
      if (bottomNavigationBarIndex.value == 1) {
        getFavorites();
      }
      return;
    }
    coin.addFavorite();
    update(["item_${coin.id}"]);
  }
}
