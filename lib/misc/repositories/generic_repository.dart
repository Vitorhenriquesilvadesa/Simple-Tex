import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:simple_tex/misc/controllers/db_manager.dart';
import '../models/generic_model.dart';
import 'igeneric_repository.dart';

class GenericRepository<M extends GenericModel> with IGenericRepository<M> {
  late DataBaseMannager dataBaseMannager;
  late String _tableName;

  @override
  set tableName(String tableName) {
    _tableName = tableName;
  }

  GenericRepository({required tableName}) {
    dataBaseMannager = DataBaseMannager();
    //deleteTable();
    _tableName = tableName;
  }

  @override
  Future<void> add(M model) async {
    Database db = await dataBaseMannager.dataBase;
    await db.insert(_tableName, model.toMap());
  }

  @override
  Future<void> delete(String id) async {
    Database db = await dataBaseMannager.dataBase;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<void> deleteModel(M model) async {
    Database db = await dataBaseMannager.dataBase;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [model.id]);
  }

  @override
  Future<List<M>> getAll() async {
    debugPrint('Getting all register from table $_tableName');
    Database db = await dataBaseMannager.dataBase;
    List<Map<String, dynamic>> modelsMap = await db.query(_tableName);
    List<M> models = [];
    for (var data in modelsMap) {
      M model = GenericModel.getModel<M>(ModelType.user, data)!;
      models.add(model);
    }

    return models;
  }

  @override
  Future<void> update(M model) async {
    debugPrint("Updating model in table $_tableName with id ${model.id}");
    Database db = await dataBaseMannager.dataBase;
    db.update(_tableName, model.toMap(),
        where: 'id = ?', whereArgs: [model.id]);
  }
}
