import 'package:flutter/material.dart';
import 'package:simple_tex/core/app/app_config.dart';

// ignore: must_be_immutable
class BookMark extends StatelessWidget {
  String text;
  Color? color;

  BookMark({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      textStyle: const TextStyle(color: Colors.white, fontSize: 20),
      child: Container(
        width: 800,
        color: AppColors.get(Palette.cardMainColor),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: parseText(text),
        ),
      ),
    );
  }

  List<Widget> parseText(String text) {
    List<Widget> listContent = [];

    List<String> lines = text.split("\n");

    for (String line in lines) {
      if (line.isNotEmpty) {
        listContent.add(BookMarkerLine(text: line, color: color));
      }
    }

    return listContent;
  }
}

// ignore: must_be_immutable
class BookMarkerLine extends StatelessWidget {
  String text;
  Color? color;
  BookMarkerLine({super.key, required this.text, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 800,
      color: Colors.transparent,
      child: Row(children: <Widget>[
        Container(
            color: color ?? Colors.white,
            width: 4,
            height: 32,
            margin: const EdgeInsets.only(right: 16)),
        SizedBox(
          width: 740,
          child: Text(
            text,
            softWrap: true,
          ),
        )
      ]),
    );
  }
}
