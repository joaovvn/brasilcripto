import 'package:brasil_cripto/core/utils/custom_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';

class AppConnectivity {
  static void listenConnectivity(
    RxBool isOnline,
  ) {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (result.contains(ConnectivityResult.none)) {
        isOnline.value = false;
        if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
        CustomSnackBar.throwErrorSnackBar("No Connection",
            duration: Duration(days: 365));
      } else if (!isOnline.value) {
        isOnline.value = true;
        if (Get.isSnackbarOpen) Get.closeCurrentSnackbar();
        CustomSnackBar.throwSuccessSnackBar("Back Online",
            duration: Duration(seconds: 2));
      }
    });
  }
}
