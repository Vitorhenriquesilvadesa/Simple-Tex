import 'package:flutter/material.dart';
import 'package:simple_tex/core/app/app_config.dart';

// ignore: must_be_immutable
class HText extends StatelessWidget {
  int size;
  String text;
  HText({super.key, required this.size, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.get(Palette.cardMainColor),
      margin: const EdgeInsets.symmetric(horizontal: 60),
      padding: const EdgeInsets.only(bottom: 16, top: 16),
      child: Material(
        type: MaterialType.transparency,
        textStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: size * 12 + 10,
        ),
        child: SizedBox(
          width: 800,
          child: Text(text),
        ),
      ),
    );
  }
}
