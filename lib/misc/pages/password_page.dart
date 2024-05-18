import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/models/user_model.dart';
import 'package:simple_tex/misc/pages/home_page.dart';
import 'package:simple_tex/misc/repositories/pin_repository.dart';
import 'package:simple_tex/widgets/blur_image.dart';

// ignore: must_be_immutable
class PasswordPage extends StatefulWidget {
  PasswordPage({super.key, required this.user});

  User user;

  @override
  State<StatefulWidget> createState() => PasswordPageState();
}

class PasswordPageState extends State<PasswordPage> {
  final TextEditingController _passwordController = TextEditingController();
  var isRight = false.obs;

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
          child: Container(
              margin: const EdgeInsets.all(32),
              width: 300,
              height: 380,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.get(Palette.cardMainColor),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.get(Palette.languageTabColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white, size: 32),
                      ),
                    ),
                  ),
                  Container(height: 40),
                  const Material(
                    type: MaterialType.transparency,
                    child: Text("Digite a senha",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'RobotoMono',
                            fontSize: 24)),
                  ),
                  Container(height: 20),
                  Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: 200,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.get(Palette.languageTabColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                          controller: _passwordController,
                          style: const TextStyle(
                              color: Colors.white, fontFamily: 'RobotoMono'),
                          decoration: const InputDecoration(
                            label: Text("User"),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              gapPadding: 0,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              gapPadding: 0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              gapPadding: 0,
                            ),
                          )),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      if (_passwordController.text == widget.user.password) {
                        PinController controller = Get.find<PinController>();
                        controller.setUser(widget.user.name);
                        Get.off(() => const HomePage());
                      } else {
                        isRight.value = true;
                      }
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(64),
                        color: AppColors.get(Palette.languageTabColor),
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
                  Obx(
                    () => isRight.isTrue
                        ? const Material(
                            type: MaterialType.transparency,
                            child: Text("Senha incorreta",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 255, 69, 125),
                                    fontFamily: 'RobotoMono',
                                    fontSize: 24)),
                          )
                        : Container(),
                  ),
                ],
              )),
        )
      ],
    );
  }
}
