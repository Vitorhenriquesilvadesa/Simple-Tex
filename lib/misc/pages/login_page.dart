import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/models/user_model.dart';
import 'package:simple_tex/misc/pages/password_page.dart';
import 'package:simple_tex/misc/repositories/settings.dart';
import 'package:simple_tex/misc/controllers/user_controller.dart';
import 'package:simple_tex/widgets/blur_image.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BlurImage(
          imagePath: "lib/res/images/background002.jpeg",
          blurIntensity: 100,
          opacity: 0.5,
        ),
        Center(
          child: Column(
            children: [
              Material(
                type: MaterialType.transparency,
                child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.get(Palette.cardBackgroundColor),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white, size: 32),
                    )),
              ),
              Container(
                  margin: const EdgeInsets.all(32),
                  height: 670,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.get(Palette.cardMainColor),
                      borderRadius: BorderRadius.circular(20)),
                  child: GetBuilder<UserController>(builder: (controller) {
                    Color color = Color.fromRGBO(
                        Random.secure().nextInt(150),
                        Random.secure().nextInt(150),
                        Random.secure().nextInt(150),
                        1);

                    Color color2 = Color.fromRGBO(
                        color.red + 50, color.green + 50, color.blue + 50, 1);

                    Color color3 = Color.fromRGBO(color.red + 100,
                        color.green + 100, color.blue + 100, 1);

                    return GridView.builder(
                        itemCount: controller.users.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemBuilder: (context, index) {
                          return Material(
                            type: MaterialType.transparency,
                            child: Container(
                              margin: const EdgeInsets.all(16),
                              width: 200,
                              height: 300,
                              decoration: BoxDecoration(
                                color: AppColors.get(Palette.cardMainColor),
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 16,
                                    spreadRadius: 10,
                                    color: Colors.black.withOpacity(0.3),
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(height: 32),
                                  Container(
                                    width: 128,
                                    height: 128,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(128),
                                      gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [color, color2, color3]),
                                    ),
                                  ),
                                  Text(
                                    controller.users[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'RobotoMono',
                                    ),
                                  ),
                                  Container(height: 64),
                                  GestureDetector(
                                    onTap: () {
                                      userName = controller.users[index].name;
                                      Get.to(PasswordPage(
                                          user: controller.users[index]));
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(64),
                                        color: AppColors.get(
                                            Palette.languageTabColor),
                                      ),
                                      alignment: Alignment.center,
                                      width: 180,
                                      height: 50,
                                      child: const Material(
                                        type: MaterialType.transparency,
                                        child: Text(
                                          "Entrar",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'RobotoMono',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(height: 32),
                                  GestureDetector(
                                    onTap: () async {
                                      String result = await _showSelectionDialog(
                                          context,
                                          ["sim", "não"],
                                          "Deseja deletar o perfil de $userName");
                                      if (result == "sim") {
                                        List<User> users = controller.users;
                                        controller.deleteModel(users[index]);
                                        setState(() {});
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(64),
                                        color: AppColors.get(
                                            Palette.languageTabColor),
                                      ),
                                      alignment: Alignment.center,
                                      width: 200,
                                      height: 50,
                                      child: const Material(
                                        type: MaterialType.transparency,
                                        child: Text(
                                          "Deletar usuario",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'RobotoMono',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  })),
            ],
          ),
        ),
      ],
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
