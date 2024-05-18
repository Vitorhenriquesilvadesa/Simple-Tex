import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/repositories/pin_repository.dart';
import 'package:simple_tex/widgets/blur_image.dart';
import 'package:simple_tex/widgets/bookmark.dart';
import 'package:simple_tex/widgets/code_scope.dart';
import 'package:simple_tex/widgets/list_element.dart';
import 'package:simple_tex/widgets/text_scope.dart';
import 'package:simple_tex/widgets/title.dart';

import '../models/pin_model.dart';

// ignore: must_be_immutable
class ExpandedPublication extends StatelessWidget {
  int index;

  Map<String, Color> colors = {
    "blue": Colors.blueAccent,
    "red": Colors.redAccent,
    "yellow": Colors.amberAccent,
    "green": Colors.greenAccent,
    "pink": Colors.pinkAccent,
  };

  ExpandedPublication({super.key, required this.index});

  List<Widget> parseMarkdown(String content, Pin pin) {
    List<String> lines = content.split("\n");
    List<Widget> widgets = [];

    String currentCodeValue = "";
    bool coding = false;
    String language = "";
    String title = "";
    bool coloredText = false;
    String color = "";
    bool isBookMark = false;
    String bookMarkText = "";

    for (int i = 0; i < lines.length; i++) {
      String line = lines[i];

      if (isBookMark && !line.startsWith("</book>")) {
        bookMarkText += "$line\n";
        continue;
      } else if (line.startsWith("@title")) {
        title = line.replaceAll("@title", "");
        widgets.add(Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title),
            Container(
              width: 112,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.all(20),
              child: Image.file(
                File(pin.thumbnail),
              ),
            )
          ],
        ));
        widgets.add(Container(height: 32));

        if ((i + 2) < lines.length) {
          if (!lines[i + 1].startsWith("@author") &&
              !lines[i + 2].startsWith("@author")) {
            i += 2;
          }
          continue;
        }
      } else if (line.startsWith("@author")) {
        widgets.add(
          TextScope(
            fontWeight: FontWeight.bold,
            content:
                "Document Creator: ${line.replaceFirst("@author", "").replaceFirst(" ", "")}",
          ),
        );
      } else if (line.startsWith("<image>")) {
        widgets.add(
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Image.file(
              File(
                line.replaceFirst("<image>", ""),
              ),
              width: 800,
            ),
          ),
        );
      } else if (line.startsWith("<book>")) {
        isBookMark = true;
        widgets.add(Container(
            height: 48,
            width: 800,
            color: AppColors.get(Palette.cardMainColor)));
        continue;
      } else if (line.startsWith("</book>")) {
        widgets.add(BookMark(text: bookMarkText, color: colors[color]));
        bookMarkText = "";
        isBookMark = false;
        widgets.add(Container(
            height: 48,
            width: 800,
            color: AppColors.get(Palette.cardMainColor)));
        continue;
      } else if (line
          .replaceAll("\n", "")
          .replaceAll(" ", "")
          .replaceAll("\t", "")
          .isEmpty) {
        // widgets.add(Container(
        //     height: 32,
        //     width: 800,
        //     color: AppColors.get(Palette.cardMainColor)));
        continue;
      } else if (line.startsWith("<color>")) {
        coloredText = true;
        color = line.replaceFirst("<color>", "");
        color = color.replaceAll(" ", "");
        continue;
      } else if (line.startsWith("</color>")) {
        color = "";
        coloredText = false;
        continue;
      } else if (coloredText) {
        if (colors[color] != null) {
          widgets.add(TextScope(content: line, color: colors[color]));
          continue;
        } else {
          widgets.add(TextScope(content: line, color: Colors.cyan));
          continue;
        }
      } else if (line.startsWith("</code>")) {
        widgets.add(CodeScope(language: language, code: currentCodeValue));
        coding = false;
        currentCodeValue = "";
        language = "";
        continue;
      } else if (coding) {
        currentCodeValue += "$line\n";
        continue;
      } else if (line.startsWith("<code>")) {
        coding = true;
        language = line.replaceAll("<code>", "");
        continue;
      } else if (line.startsWith("-")) {
        widgets.add(ListElement(
          content: line.substring(1),
        ));
        continue;
      } else if (line.startsWith("###")) {
        widgets.add(HText(size: 1, text: line.replaceFirst("###", "")));
      } else if (line.startsWith("##")) {
        widgets.add(HText(size: 2, text: line.replaceFirst("##", "")));
      } else if (line.startsWith("#")) {
        widgets.add(HText(size: 3, text: line.replaceFirst("#", "")));
      } else if (line.isNotEmpty) {
        widgets.add(TextScope(content: line));
      }
    }

    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    List<Pin> pins = Get.find<PinController>().getAll();
    Pin pin = pins[index];
    return Stack(
      children: [
        BlurImage(
          imagePath: "lib/images/background002.jpeg",
          blurIntensity: 100,
          opacity: 0.5,
        ),
        Center(
          child: Container(
            color: const Color.fromRGBO(12, 12, 12, 0.6),
            height: 800,
            width: 1000,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Material(
                  type: MaterialType.transparency,
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 700,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Material(
                          type: MaterialType.transparency,
                          textStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                          child: Column(
                              children:
                                  parseMarkdown(pin.markdownContent, pin)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
