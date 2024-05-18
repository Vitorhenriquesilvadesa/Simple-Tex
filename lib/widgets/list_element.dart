import 'package:flutter/material.dart';
import 'package:simple_tex/core/app/app_config.dart';

// ignore: must_be_immutable
class ListElement extends StatelessWidget {
  String content;

  ListElement({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        width: 800,
        height: 32,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        color: AppColors.get(Palette.cardMainColor),
        child: Row(
          children: [
            Container(color: Colors.transparent, width: 15),
            const Icon(Icons.circle, size: 8, color: Colors.white),
            Container(color: Colors.transparent, width: 8),
            SizedBox(
              width: 700,
              child: Text(
                content,
                style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'RobotoMono'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
