import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/models/pin_model.dart';
import 'package:simple_tex/misc/repositories/pin_repository.dart';
import 'package:simple_tex/misc/repositories/settings.dart';
import 'package:simple_tex/widgets/pin_card.dart';

class PublicationsScrollView extends StatefulWidget {
  const PublicationsScrollView({super.key});

  @override
  State<StatefulWidget> createState() => PublicationsScrollViewState();
}

class PublicationsScrollViewState extends State<PublicationsScrollView> {
  List<Pin> pins = [];
  final PinController repository = Get.find();

  void updatePins() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    pins = repository.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SizedBox(
        width: 700,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16, bottom: 16),
              decoration: BoxDecoration(
                color: AppColors.get(Palette.languageTabColor),
                borderRadius: BorderRadius.circular(32),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    repository.addPin(
                      Pin(
                          id: repository.pins.length,
                          markdownContent: "@title untitled",
                          title: "untitled",
                          thumbnail: "res/images/default_thumbnail.png"),
                      userName,
                    );

                    pins = repository.getAll();
                  });
                },
                icon: const Icon(Icons.add, color: Colors.white, size: 24),
              ),
            ),
            if (repository.pins.isEmpty)
              const Text(
                "No Pins Created",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontFamily: 'RobotoMono'),
              )
            else
              GetBuilder<PinController>(
                builder: (controller) => Expanded(
                  child: ListView.builder(
                    itemCount: controller.pins.length,
                    itemBuilder: (context, index) {
                      return PinCard(
                        index: index,
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
