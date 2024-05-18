import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/models/pin_model.dart';
import 'package:simple_tex/misc/repositories/pin_repository.dart';
import 'package:simple_tex/misc/repositories/settings.dart';
import 'package:simple_tex/widgets/blur_image.dart';

// ignore: must_be_immutable
class MarkDownEditor extends StatefulWidget {
  int pinIndex;

  MarkDownEditor({super.key, required this.pinIndex});

  @override
  MarkDownEditorState createState() => MarkDownEditorState();
}

class MarkDownEditorState extends State<MarkDownEditor> {
  late TextEditingController _controller;
  Pin? pin;
  Map<String, dynamic>? arguments;

  @override
  void initState() {
    super.initState();
    // print(Get.arguments);
    // arguments = Get.arguments as Map<String, dynamic>;
    // pin = arguments?['pin'];

    // print(pin);

    // _controller.text = pin!.markdownContent;
    // print("Text controller value: ${_controller.text}");
  }

  String extractTitle(String text) {
    List<String> lines = text.split("\n");
    for (String line in lines) {
      if (line.startsWith("@title")) {
        return line.replaceAll("@title", "");
      }
    }

    return "Untitled";
  }

  var isSaved = true.obs;
  bool isSavedOffset = true;
  final PinController repository = Get.find();

  @override
  Widget build(BuildContext context) {
    List<Pin> pins = Get.find<PinController>().getAll();
    pin = pins[widget.pinIndex];
    _controller =
        TextEditingController(text: pins[widget.pinIndex].markdownContent);

    return Scaffold(
      body: Stack(
        children: [
          BlurImage(
            imagePath: "lib/res/images/background002.jpeg",
            blurIntensity: 100,
            opacity: 0.5,
          ),
          Container(
            width: double.infinity,
            color: Colors.transparent,
            child: Center(
              child: SizedBox(
                width: 800,
                child: Material(
                  type: MaterialType.transparency,
                  child: SizedBox(
                    width: 200,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 24),
                          width: 800,
                          height: 32,
                          color: const Color.fromRGBO(12, 12, 12, 0.5),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () async {
                                      FilePickerResult? result =
                                          await FilePicker.platform.pickFiles();

                                      if (result != null) {
                                        File file =
                                            File(result.files.single.path!);
                                        String text = _controller.text;
                                        _controller.text =
                                            "$text\n<image>${file.path}";
                                      }
                                    },
                                    color:
                                        AppColors.get(Palette.languageTabColor),
                                    icon: const Icon(Icons.image,
                                        color: Colors.white, size: 24),
                                    splashRadius: 10,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String language =
                                          await _showSelectionDialog(
                                              context,
                                              languages,
                                              "Selecione uma linguagem");

                                      _updateButtonText(language, "code");
                                    },
                                    color:
                                        AppColors.get(Palette.languageTabColor),
                                    icon: const Icon(Icons.code,
                                        color: Colors.white, size: 24),
                                    splashRadius: 10,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String color = await _showSelectionDialog(
                                          context, colors, "Selecione uma cor");

                                      _updateButtonText(color, "color");
                                    },
                                    color:
                                        AppColors.get(Palette.languageTabColor),
                                    icon: const Icon(Icons.color_lens_outlined,
                                        color: Colors.white, size: 24),
                                    splashRadius: 10,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String text = _controller.text;
                                      _controller.text =
                                          "$text\n<book>\n\n</book>";
                                    },
                                    color:
                                        AppColors.get(Palette.languageTabColor),
                                    icon: const Icon(Icons.bookmark,
                                        color: Colors.white, size: 24),
                                    splashRadius: 10,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      String header =
                                          await _showSelectionDialog(context,
                                              headers, "Selecione um tamanho");

                                      String text = _controller.text;

                                      if (header.indexOf(header) == 0) {
                                        _controller.text = "$text\n# ";
                                      } else if (header.indexOf(header) == 1) {
                                        _controller.text = "$text\n## ";
                                      } else {
                                        _controller.text = "$text\n### ";
                                      }
                                    },
                                    color:
                                        AppColors.get(Palette.languageTabColor),
                                    icon: const Icon(FontAwesomeIcons.heading,
                                        color: Colors.white, size: 20),
                                    splashRadius: 10,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    child: Obx(() {
                                      if (isSaved.isTrue) {
                                        return SizedBox(
                                          width: 400,
                                          child: Text(
                                            "${pin!.title} (saved)",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        );
                                      } else {
                                        return SizedBox(
                                          width: 400,
                                          child: Text(
                                            "${pin!.title}* (not saved)",
                                            style: const TextStyle(
                                                fontSize: 20,
                                                overflow: TextOverflow.ellipsis,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        );
                                      }
                                    }),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      pin!.title =
                                          extractTitle(_controller.text);
                                      pin!.markdownContent = _controller.text;
                                      repository.updatePin(
                                          pin!.id, pin!, userName);
                                      isSaved.value = true;
                                      Navigator.of(context).pop();
                                    },
                                    color:
                                        AppColors.get(Palette.languageTabColor),
                                    icon: const Icon(Icons.close_rounded,
                                        color: Colors.white, size: 24),
                                    splashRadius: 10,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: 800,
                          height: 710,
                          padding: const EdgeInsets.all(32),
                          alignment: Alignment.topCenter,
                          color: const Color.fromRGBO(12, 12, 12, 0.5),
                          child: SingleChildScrollView(
                            child: Container(
                              color: const Color.fromRGBO(100, 100, 100, 0.2),
                              child: TextField(
                                controller: _controller,
                                onChanged: (value) {
                                  if ((_controller.text.length - 9) % 60 == 0) {
                                    isSavedOffset = false;
                                  }
                                  if (_controller.text.length % 60 == 0 ||
                                      isSavedOffset) {
                                    pin!.title = extractTitle(_controller.text);
                                    pin!.markdownContent = _controller.text;
                                    repository.updatePin(
                                        pin!.id, pin!, userName);
                                    isSaved.value = true;
                                    isSavedOffset = true;
                                  } else if (!isSavedOffset) {
                                    isSaved.value = false;
                                  }
                                },
                                autofocus: true,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'RobotoMono'),
                                inputFormatters: [
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    if (newValue.text.startsWith('@title')) {
                                      return TextEditingValue(
                                        text: newValue.text,
                                        selection: newValue.selection,
                                        composing: TextRange.empty,
                                      );
                                    }
                                    return newValue;
                                  }),
                                ],
                                cursorColor: Colors.white,
                                textAlign: TextAlign.justify,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    gapPadding: 0,
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    gapPadding: 0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.transparent),
                                    gapPadding: 0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<dynamic> _showSelectionDialog(
      BuildContext context, List<String> items, String title) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
            title: Text(title), children: createLanguageOptions(items));
      },
    );
  }

  List<Widget> createLanguageOptions(List<String> options) {
    List<Widget> optionsWidgets = [];

    for (String language in options) {
      optionsWidgets.add(
        SimpleDialogOption(
          onPressed: () {
            Navigator.pop(context, language);
          },
          child: Text(language),
        ),
      );
    }

    return optionsWidgets;
  }

  void _updateButtonText(String selectedItem, String tag) {
    String currentText = _controller.text;
    _controller.text = "$currentText\n<$tag> $selectedItem\n\n</$tag>";
  }
}

List<String> languages = [
  'JavaScript',
  'Python',
  'Java',
  'C#',
  'C++',
  'Ruby',
  'Swift',
  'TypeScript',
  'Go',
  'Kotlin',
  'Dart',
  'PHP',
  'Rust',
  'Objective-C',
  'R',
  'Shell',
  'Scala',
  'Perl',
  'Haskell',
  'Lua',
];

List<String> colors = ["red", "yellow", "blue", "pink", "green"];

List<String> headers = ["título grande", "título normal", "subtítulo"];
