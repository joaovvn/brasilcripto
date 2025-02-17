import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/core/constants/app_images.dart';
import 'package:brasil_cripto/features/home/view_model/home_view_model.dart';
import 'package:brasil_cripto/features/home/widgets/coin_not_found.dart';
import 'package:brasil_cripto/features/home/widgets/custom_search_bar.dart';
import 'package:brasil_cripto/features/home/widgets/empty_favorites.dart';
import 'package:brasil_cripto/features/home/widgets/search_card.dart';
import 'package:brasil_cripto/features/home/widgets/trending_card.dart';
import 'package:brasil_cripto/features/home/widgets/trending_title.dart';
import 'package:brasil_cripto/shared/models/search/crypto_search_result.dart';
import 'package:brasil_cripto/shared/models/trending/trending_crypto_item.dart';
import 'package:brasil_cripto/shared/widgets/updated_at_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  final HomeViewModel _homeViewModel = Get.put(HomeViewModel());

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Image.asset(
          AppImages.logo,
          scale: 1.5,
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            currentIndex: _homeViewModel.bottomNavigationBarIndex.value,
            backgroundColor: AppColors.primary,
            selectedItemColor: AppColors.secondary,
            unselectedItemColor: AppColors.secondary.withAlpha(50),
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            onTap: (index) => _homeViewModel.onTapItem(index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star_rounded), label: "Favorites")
            ]);
      }),
      body: RefreshIndicator(
        backgroundColor: AppColors.cryptoCard,
        color: AppColors.secondary,
        onRefresh: () => _homeViewModel.onRefresh(),
        child: Obx(() {
          List<CryptoSearchResult> list =
              _homeViewModel.bottomNavigationBarIndex.value == 0
                  ? _homeViewModel.cryptos
                  : _homeViewModel.favorites;
          return CustomScrollView(
            slivers: [
              _homeViewModel.isOnline.value
                  ? SliverPersistentHeader(
                      pinned: false,
                      floating: true,
                      delegate: CustomSearchBar(
                          controller:
                              _homeViewModel.bottomNavigationBarIndex.value == 0
                                  ? _homeViewModel.searchController
                                  : _homeViewModel.favoritesSearchController,
                          onSubmitted: _homeViewModel.searchCrypto),
                    )
                  : SliverToBoxAdapter(
                      child: SizedBox(),
                    ),
              _homeViewModel.isOnline.value
                  ? _homeViewModel.isLoading.value
                      ? SliverFillRemaining(
                          child: Center(
                              child: CircularProgressIndicator(
                          color: AppColors.secondary,
                        )))
                      : _homeViewModel.trendingCryptos.isEmpty
                          ? list.isEmpty
                              ? SliverFillRemaining(
                                  child: _homeViewModel
                                              .bottomNavigationBarIndex.value ==
                                          0
                                      ? CoinNotFound()
                                      : EmptyFavorites())
                              : SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 15.0),
                                  sliver: SliverList.separated(
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      CryptoSearchResult crypto = list[index];
                                      return SearchCard(
                                        crypto: crypto,
                                        homeViewModel: _homeViewModel,
                                      );
                                    },
                                    separatorBuilder: (context, index) =>
                                        Divider(
                                      color: AppColors.secondary.withAlpha(150),
                                    ),
                                  ),
                                )
                          : SliverMainAxisGroup(
                              slivers: [
                                SliverPersistentHeader(
                                  pinned: true,
                                  floating: true,
                                  delegate: TrendingTitle(),
                                ),
                                SliverPadding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  sliver: SliverMainAxisGroup(
                                    slivers: [
                                      SliverToBoxAdapter(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: UpdatedAtWidget(),
                                        ),
                                      ),
                                      SliverList.builder(
                                        itemCount: _homeViewModel
                                            .trendingCryptos.length,
                                        itemBuilder: (context, index) {
                                          TrendingCryptoItem cryptoItem =
                                              _homeViewModel
                                                  .trendingCryptos[index].item;
                                          return TrendingCard(
                                            cryptoItem: cryptoItem,
                                            onTap: () => _homeViewModel
                                                .openDetailsScreen(
                                                    cryptoItem.id),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                  : SliverFillRemaining(
                      child: Center(child: Image.asset(AppImages.noConnection)),
                    )
            ],
          );
        }),
      ),
    );
  }
}
