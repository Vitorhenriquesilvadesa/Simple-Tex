import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/pages/start_page.dart';
import '../../widgets/blur_image.dart';
import '../../widgets/pins.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext contex) {
    return Container(
      color: Colors.black,
      child: Stack(
        alignment: Alignment.topRight,
        children: <Widget>[
          BlurImage(
            imagePath: "lib/res/images/background002.jpeg",
            blurIntensity: 100,
            opacity: 0.5,
          ),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () async {
                            Get.offAll(const StartPage());
                          },
                          icon: const Icon(Icons.arrow_back,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Material(
                  type: MaterialType.transparency,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IconButton(
                          onPressed: () async {
                            // String filePath =
                            //     await _showSelectionDialog(context, [], "");
                          },
                          icon: const Icon(Icons.image_search,
                              color: Colors.white)),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    width: AppConfig.publicationCardWidth > 400
                        ? 400
                        : AppConfig.publicationCardWidth,
                    child: const PublicationsScrollView(),
                  ),
                ),
              ),
            ],
          ),
          //const AssistanceNotifier(),
        ],
      ),
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

List<String> backgrounds = [];
