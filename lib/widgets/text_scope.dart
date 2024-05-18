import 'package:flutter/material.dart';
import 'package:simple_tex/core/app/app_config.dart';

// ignore: must_be_immutable
class TextScope extends StatelessWidget {
  String content;
  Color? color;
  late FontWeight fontWeight;

  TextScope(
      {super.key, required this.content, this.color, FontWeight? fontWeight}) {
    if (fontWeight != null) {
      this.fontWeight = fontWeight;
    } else {
      this.fontWeight = FontWeight.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 60, right: 60),
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      width: 800,
      decoration: BoxDecoration(
        color: AppColors.get(Palette.cardMainColor),
        // borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        content,
        textAlign: TextAlign.justify,
        style: TextStyle(
            color: color ?? Colors.white, fontSize: 20, fontWeight: fontWeight),
      ),
    );
  }
}
