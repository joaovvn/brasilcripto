import 'dart:async';

import 'package:brasil_cripto/core/utils/custom_snack_bar.dart';
import 'package:brasil_cripto/shared/models/details/crypto_coin_details.dart';
import 'package:brasil_cripto/shared/repositories/crypto_repository_impl.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class DetailsViewModel extends GetxController {
  final CryptoRepositoryImpl _cryptoRepository = Get.find();

  Rx<CryptoCoinDetails?> crypto = null.obs;
  RxBool isLoading = false.obs;
  RxBool refreshLoading = false.obs;
  final String coinId;
  Timer? _timer;
  RxBool isFavorite = false.obs;

  RxList<double> priceList = List<double>.empty(growable: true).obs;
  double maxPrice = 0;
  double minPrice = 0;
  double currentPrice = 0;

  @override
  void onInit() async {
    await searchCryptoById();
    isFavorite.value = crypto.value?.verifyFavorite() ?? false;
    _timer = Timer.periodic(Duration(minutes: 1), (_) => refreshData());
    super.onInit();
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }

  DetailsViewModel({required this.coinId});

  void removeAddFavorite() {
    if (isFavorite.value) {
      crypto.value?.removeFavorite();
      isFavorite.value = crypto.value!.verifyFavorite();
      return;
    }
    crypto.value?.addFavorite();
    isFavorite.value = crypto.value!.verifyFavorite();
  }

  // Função para buscar detalhes da criptomoeda ao clicar no card
  Future<void> searchCryptoById() async {
    try {
      isLoading.value = true;
      var result = await _cryptoRepository.getCryptoDetails(coinId);
      crypto = result.obs;
      priceList = crypto.value!.data.sparkline.price.obs;
      maxPrice = priceList.reduce(math.max);
      minPrice = priceList.reduce(math.min);
      currentPrice = priceList.last;
    } catch (e) {
      Get.back();
      CustomSnackBar.throwErrorSnackBar(e.toString());
    } finally {
      if (crypto.value != null) {
        isLoading.value = false;
      }
    }
  }

  //Função para atualizar dados a cada 1 minuto (Informação da documentação -> Cache/Update Frequency: Every 60 seconds for all the API plans.)
  Future<void> refreshData() async {
    try {
      refreshLoading.value = true;
      var result = await _cryptoRepository.getCryptoDetails(coinId);
      crypto = result.obs;
      priceList = crypto.value!.data.sparkline.price.obs;
      maxPrice = priceList.reduce(math.max);
      minPrice = priceList.reduce(math.min);
      currentPrice = priceList.last;
    } catch (e) {
      CustomSnackBar.throwErrorSnackBar(e.toString());
    } finally {
      refreshLoading.value = false;
    }
  }
}
