import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_tex/CoreX/core_xperience.dart';
import 'package:simple_tex/misc/repositories/pin_repository.dart';
import 'package:simple_tex/misc/repositories/settings.dart';
import 'package:simple_tex/misc/controllers/user_controller.dart';
import 'package:simple_tex/misc/repositories/user_repository.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app.dart';

Future<void> main() async {
  CoreX.init();
  await Settings.init();

  if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
  }

  databaseFactory = databaseFactoryFfi;

  Get.put(UserRepository(tableName: "users"));
  Get.put(UserController(repository: Get.find()));
  Get.put(PinController("default"));

  runApp(
    const PopcornRank(),
  );
}
