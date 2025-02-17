import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/core/constants/app_images.dart';
import 'package:brasil_cripto/core/utils/formatters.dart';
import 'package:brasil_cripto/features/details/view_model/details_view_model.dart';
import 'package:brasil_cripto/features/details/widgets/details_header.dart';
import 'package:brasil_cripto/features/details/widgets/graph.dart';
import 'package:brasil_cripto/features/details/widgets/price_label.dart';
import 'package:brasil_cripto/features/details/widgets/html_text.dart';
import 'package:brasil_cripto/shared/widgets/favorite_button.dart';
import 'package:brasil_cripto/shared/widgets/price_change_widget.dart';
import 'package:brasil_cripto/shared/widgets/updated_at_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailsView extends StatelessWidget {
  const DetailsView({super.key, required this.coinId});

  final String coinId;

  @override
  Widget build(BuildContext context) {
    final DetailsViewModel detailsViewModel =
        Get.put(DetailsViewModel(coinId: coinId));

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Image.asset(
          AppImages.logo,
          scale: 1.5,
        ),
        actions: [
          Obx(() {
            return detailsViewModel.isLoading.value
                ? SizedBox()
                : FavoriteButton(
                    cryptoName: detailsViewModel.crypto.value!.name,
                    onPressed: () => detailsViewModel.removeAddFavorite(),
                    isFavorite: detailsViewModel.isFavorite.value,
                  );
          })
        ],
      ),
      body: Obx(() {
        return CustomScrollView(
          slivers: [
            detailsViewModel.isLoading.value
                ? SliverFillRemaining(
                    child: Center(
                        child: CircularProgressIndicator(
                    color: AppColors.secondary,
                  )))
                : SliverMainAxisGroup(
                    slivers: [
                      SliverPersistentHeader(
                        pinned: true,
                        floating: true,
                        delegate: DetailsHeader(
                            crypto: detailsViewModel.crypto.value!),
                      ),
                      SliverPadding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 20.0),
                        sliver: SliverToBoxAdapter(
                          child: Column(
                            spacing: 20,
                            children: [
                              Text("7 Days Prices",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondary)),
                              Graph(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  UpdatedAtWidget(),
                                ],
                              ),
                              Column(
                                spacing: 10,
                                children: [
                                  PriceLabel(
                                    color: AppColors.green,
                                    text:
                                        "Highest price: ${Formatters.formatCryptoPrice(detailsViewModel.maxPrice)}",
                                  ),
                                  PriceLabel(
                                    color: AppColors.red,
                                    text:
                                        "Lowest price: ${Formatters.formatCryptoPrice(detailsViewModel.minPrice)}",
                                  ),
                                  PriceLabel(
                                    color: AppColors.secondary,
                                    text:
                                        "Current price: ${Formatters.formatCryptoPrice(detailsViewModel.currentPrice)}",
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "7 Days Price Change: ",
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.secondary,
                                        ),
                                      ),
                                      PriceChangeWidget(
                                          value: detailsViewModel.crypto.value!
                                              .data.priceChangePercentage7d,
                                          formattedValue: detailsViewModel
                                              .crypto.value!.data
                                              .formattedPriceChangePercentage()),
                                    ],
                                  )
                                ],
                              ),
                              Divider(
                                  color: AppColors.secondary.withAlpha(150)),
                              Text("Description",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.secondary)),
                              detailsViewModel
                                      .crypto.value!.description.en.isEmpty
                                  ? Text("Description not Provided",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color:
                                            AppColors.secondary.withAlpha(150),
                                      ))
                                  : HtmlText(
                                      detailsViewModel
                                          .crypto.value!.description.en,
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
          ],
        );
      }),
    );
  }
}
