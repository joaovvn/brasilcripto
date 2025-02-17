import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/core/services/api_service.dart';
import 'package:brasil_cripto/features/home/view/home_view.dart';
import 'package:brasil_cripto/shared/repositories/crypto_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  Get.put(CryptoRepositoryImpl(ApiService()));
  runApp(const BrasilCripto());
}

class BrasilCripto extends StatelessWidget {
  const BrasilCripto({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Theme.of(context).copyWith(
            splashFactory: NoSplash.splashFactory,
            textTheme:
                TextTheme.of(context).apply(bodyColor: AppColors.secondary),
            appBarTheme: Theme.of(context).appBarTheme.copyWith(
                  color: AppColors.primary,
                  centerTitle: true,
                ),
            scaffoldBackgroundColor: AppColors.primary),
        home: HomeView(),
      ),
    );
  }
}
