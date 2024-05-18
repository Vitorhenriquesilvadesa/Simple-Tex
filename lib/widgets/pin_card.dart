import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/models/pin_model.dart';
import 'package:simple_tex/misc/pages/markdown_editor.dart';
import 'package:simple_tex/misc/repositories/pin_repository.dart';
import 'package:simple_tex/misc/pages/expanded_publication.dart';
import 'package:simple_tex/misc/repositories/settings.dart';

// ignore: must_be_immutable
class PinCard extends StatefulWidget {
  int index;

  PinCard({Key? key, required this.index}) : super(key: key);

  @override
  State<PinCard> createState() => PinCardState();
}

class PinCardState extends State<PinCard> {
  bool expanded = false;
  bool showIcons = false;

  PinCardState();

  @override
  Widget build(BuildContext context) {
    Pin pin = Get.find<PinController>().getAll()[widget.index];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      height: expanded
          ? AppConfig.publicationMaxHeight
          : AppConfig.publicationMinizedHeight,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10,
            blurStyle: BlurStyle.normal,
            offset: const Offset(0, 10),
          )
        ],
        color: const Color.fromARGB(255, 91, 91, 91),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          Container(
            width: AppConfig.publicationCardWidth,
            margin: const EdgeInsets.symmetric(
              horizontal: 2,
              vertical: 2,
            ),
            alignment: Alignment.topLeft,
            decoration: BoxDecoration(
              color: AppColors.get(Palette.cardMainColor),
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              expanded = !expanded;
                              if (expanded) {
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  setState(() {
                                    showIcons = true;
                                  });
                                });
                              } else {
                                setState(() {
                                  showIcons = false;
                                });
                              }
                            });
                          },
                          child: Container(
                            height: 24,
                            alignment: Alignment.topLeft,
                            margin: const EdgeInsets.only(left: 8, top: 6),
                            decoration: BoxDecoration(
                              color: AppColors.get(Palette.codeScopeHeader),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              expanded
                                  ? Icons.arrow_drop_down
                                  : Icons.arrow_right_sharp,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          height: 32,
                          padding: const EdgeInsets.only(top: 6),
                          margin: const EdgeInsets.only(left: 8),
                          child: Material(
                            type: MaterialType.transparency,
                            child: Text(
                              pin.title,
                              style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles();

                          if (result != null) {
                            File file = File(result.files.single.path!);
                            pin.thumbnail = file.path;
                            setState(() {});
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(top: 8, right: 8),
                            child:
                                const Icon(Icons.image, color: Colors.white))),
                  ],
                ),
                if (showIcons)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 8, top: 24),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Map<String, dynamic> args = {'pin': pin};

                                //print(args);
                                Get.to(
                                    () => MarkDownEditor(
                                          pinIndex: widget.index,
                                        ),
                                    transition: Transition.fadeIn,
                                    arguments: args);
                              },
                              child: Container(
                                width: 128,
                                height: 32,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.get(Palette.codeScopeHeader),
                                ),
                                child: const Material(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  type: MaterialType.transparency,
                                  child: Text(
                                    "Editar Pin",
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                PinController controller =
                                    Get.find<PinController>();

                                String? header = await _showSelectionDialog(
                                    context,
                                    ["sim", "não"],
                                    "Deseja mesmo excluir o pin ${controller.pins[widget.index].title}?");

                                if (header == "sim") {
                                  controller.removePin(
                                      controller.getAll()[widget.index],
                                      userName);
                                }
                              },
                              child: Container(
                                width: 128,
                                height: 32,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.get(Palette.codeScopeHeader),
                                ),
                                child: const Material(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  type: MaterialType.transparency,
                                  child: Text(
                                    "Excluir Pin",
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(ExpandedPublication(index: widget.index),
                                    transition: Transition.fadeIn);
                              },
                              child: Container(
                                width: 128,
                                height: 32,
                                alignment: Alignment.center,
                                margin:
                                    const EdgeInsets.only(left: 8, bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.get(Palette.codeScopeHeader),
                                ),
                                child: const Material(
                                  textStyle: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                  type: MaterialType.transparency,
                                  child: Text(
                                    "Abrir Pin",
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                            margin:
                                const EdgeInsets.only(right: 24, bottom: 16),
                            padding: const EdgeInsets.all(8),
                            width: 112,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.get(Palette.codeScopeHeader)),
                            child: Image.file(File(pin.thumbnail)))
                      ],
                    ),
                  ),
              ],
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
}
