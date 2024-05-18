import 'package:flutter/material.dart';
import 'package:simple_tex/misc/pages/home_page.dart';
import 'package:simple_tex/misc/pages/start_page.dart';
import 'package:get/get.dart';

class PopcornRank extends StatelessWidget {
  const PopcornRank({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StartPage(),
      getPages: [
        GetPage(name: "/", page: () => const StartPage()),
        GetPage(name: "/home", page: () => const HomePage())
      ],
    );
  }
}

// class MainBiding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(PinController());
//   }
// }
