import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:brasil_cripto/features/details/view_model/details_view_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Graph extends StatelessWidget {
  Graph({super.key});

  final List<Color> gradientColors = [
    AppColors.cyan,
    AppColors.blue,
  ];

  final DetailsViewModel detailsViewModel = Get.find();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: LineChart(LineChartData(
        lineBarsData: [
          LineChartBarData(
            spots: detailsViewModel.crypto.value!.data.sparkline.price
                .asMap()
                .entries
                .map((e) => FlSpot(e.key.toDouble(), e.value))
                .toList(),
            isCurved: true,
            gradient: LinearGradient(
              colors: gradientColors,
            ),
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: FlDotData(
              getDotPainter: (spot, percent, barData, index) {
                if (detailsViewModel
                        .crypto.value!.data.sparkline.price[index] ==
                    detailsViewModel.maxPrice) {
                  return FlDotCirclePainter(color: AppColors.green, radius: 4);
                } else if (detailsViewModel
                        .crypto.value!.data.sparkline.price[index] ==
                    detailsViewModel.minPrice) {
                  return FlDotCirclePainter(color: AppColors.red, radius: 4);
                } else if (detailsViewModel
                        .crypto.value!.data.sparkline.price[index] ==
                    detailsViewModel.currentPrice) {
                  return FlDotCirclePainter(
                      color: AppColors.secondary, radius: 4);
                } else {
                  return FlDotCirclePainter(
                      color: Colors.transparent, radius: 0);
                }
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: gradientColors
                    .map((color) => color.withValues(alpha: 0.3))
                    .toList(),
              ),
            ),
          ),
        ],
        titlesData: FlTitlesData(show: false),
        gridData: FlGridData(show: false),
        borderData: FlBorderData(show: false),
      )),
    );
  }
}
