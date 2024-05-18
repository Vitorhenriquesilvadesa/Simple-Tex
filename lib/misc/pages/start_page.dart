import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/pages/login_page.dart';
import 'package:simple_tex/misc/pages/new_user_page.dart';
import 'package:simple_tex/misc/controllers/user_controller.dart';
import 'package:simple_tex/widgets/blur_image.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> {
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: 800,
                  height: 200,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(253, 246, 236, 1),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 24,
                            color: Colors.black.withOpacity(0.75),
                            offset: const Offset(0, 20),
                            spreadRadius: 4)
                      ]),
                  alignment: Alignment.center,
                  margin: const EdgeInsets.only(bottom: 200),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Material(
                        type: MaterialType.transparency,
                        child: Text(
                          "SimpleTex",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoMono',
                          ),
                        ),
                      ),
                      SizedBox(
                          width: 200,
                          child: Image.file(File("lib/res/images/logo.jpeg"))),
                    ],
                  )),
              GestureDetector(
                onTap: () {
                  Get.to(const NewUserPage());
                },
                child: Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.get(Palette.cardMainColor),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Criar novo usuario",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Get.to(const HomePage());
              //   },
              //   child: const Text("Home Page"),
              // ),

              Container(height: 50),
              GestureDetector(
                onTap: () async {
                  await Get.find<UserController>().getAll();
                  Get.to(() => const LoginPage());
                },
                child: Container(
                  width: 300,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.get(Palette.cardMainColor),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: const Material(
                    type: MaterialType.transparency,
                    child: Text(
                      "Entrar em um perfil",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
