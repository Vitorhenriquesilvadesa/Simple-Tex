import 'package:flutter/material.dart';

final class CoreX {
  static _DeviceProps? _deviceProps;

  static void init() {
    WidgetsFlutterBinding.ensureInitialized();
    _deviceProps = _DeviceProps();
  }

  // ignore: library_private_types_in_public_api
  static _DeviceProps get device {
    return _deviceProps!;
  }
}

class _DeviceProps extends WidgetsBindingObserver {
  late double dpi;
  late double width;
  late double height;
  late double logicalWidth;
  late double logicalHeight;

  _DeviceProps() {
    WidgetsBinding.instance.addObserver(this);

    width = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;

    height = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;

    dpi =
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    logicalWidth = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
        dpi;

    logicalHeight = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
        dpi;
  }

  @override
  void didChangeMetrics() {
    width = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;

    height = WidgetsBinding
        .instance.platformDispatcher.views.first.physicalSize.width;

    dpi =
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    logicalWidth = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.width /
        dpi;

    logicalHeight = WidgetsBinding
            .instance.platformDispatcher.views.first.physicalSize.height /
        dpi;
  }
}

enum Dimensions { width, height }

abstract class CoreXRepository<T extends CoreXModel> extends ChangeNotifier {
  List<T> models = [];

  List<T> getAll() {
    return models;
  }

  T getByParam(bool Function(T model) condition) {
    return models.firstWhere(condition);
  }

  T? getById(int id) {
    for (T model in models) {
      if (model.id == id) {
        return model;
      }
    }

    return null;
  }

  void add(T model) {
    models.add(model);
    notifyListeners();
  }

  void update(T model, int id) {
    int index = models.indexWhere((element) => element.id == id);
    models[index] = model;
    notifyListeners();
  }

  void loadFromDatabase();
}

mixin CoreXModel<T> {
  late int id;
  Map<String, dynamic> toMap();
}
