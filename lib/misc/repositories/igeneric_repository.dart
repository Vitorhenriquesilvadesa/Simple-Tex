import '../models/generic_model.dart';

mixin IGenericRepository<M extends GenericModel> {
  Future<List<M>> getAll();
  Future<void> delete(String id);
  Future<void> deleteModel(M model);
  Future<void> add(M model);
  Future<void> update(M model);
  set tableName(String tableName);
}
