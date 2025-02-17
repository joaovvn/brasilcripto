import 'package:brasil_cripto/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlText extends StatelessWidget {
  final String htmlContent;

  const HtmlText(this.htmlContent, {super.key});

  @override
  Widget build(BuildContext context) {
    return HtmlWidget(htmlContent.replaceAll("\r\n", "<br>"),
        onTapUrl: (url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        return await launchUrl(Uri.parse(url));
      } else {
        throw 'Não foi possível abrir o link: $url';
      }
    },
        renderMode: RenderMode.column,
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColors.secondary.withAlpha(150),
        ));
  }
}
