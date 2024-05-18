import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/core/app/app_config.dart';
import 'package:simple_tex/misc/models/user_model.dart';
import 'package:simple_tex/misc/controllers/user_controller.dart';
import 'package:simple_tex/widgets/blur_image.dart';

class NewUserPage extends StatefulWidget {
  const NewUserPage({super.key});

  @override
  State<StatefulWidget> createState() => NewUserPageState();
}

class NewUserPageState extends State<NewUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
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
              width: 400,
              height: 500,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.get(Palette.cardMainColor),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Container(height: 32),
                  Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: 300,
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.get(Palette.languageTabColor),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextField(
                          controller: _nameController,
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
                  Container(height: 50),
                  Material(
                    type: MaterialType.transparency,
                    child: Container(
                      width: 300,
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
                            label: Text("Password"),
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
                  Container(height: 30),
                  Material(
                      type: MaterialType.transparency,
                      textStyle:
                          const TextStyle(color: Colors.white, fontSize: 20),
                      child: GestureDetector(
                        onTap: () {
                          if (_nameController.text.isNotEmpty &&
                              _passwordController.text.isNotEmpty) {
                            UserController controller = Get.find();

                            controller.add(
                              User(
                                id: controller.users.length,
                                name: _nameController.text,
                                password: _passwordController.text,
                              ),
                            );
                          }

                          Navigator.of(context).pop();
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: AppColors.get(Palette.codeScopeHeader),
                                borderRadius: BorderRadius.circular(40)),
                            alignment: Alignment.center,
                            width: 100,
                            height: 50,
                            child: const Text("Criar")),
                      ))
                ],
              )),
        ),
      ],
    );
  }
}
