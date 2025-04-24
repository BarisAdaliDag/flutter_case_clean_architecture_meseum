import 'package:path_provider/path_provider.dart';
import 'package:objectbox/objectbox.dart';

import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

import '../../../../../objectbox.g.dart';

abstract class CollectionLocalDatasource {
  Future<List<DepartmentModel>> getDepartments();
  Future<ObjectsIdModel?> getObjectsByDepartmentId({required int departmentId});
  Future<ObjectModel?> getObjectDetails({required int objectId});
  Future<void> saveDepartments(List<DepartmentModel> departments);
  Future<void> saveObjectsByDepartmentId(ObjectsIdModel departmentIdModel);
  Future<void> saveObjectDetails(ObjectModel objectIdModel);
}

final class CollectionLocalDatasourceImpl implements CollectionLocalDatasource {
  final Store store;
  late final Box<DepartmentModel> _departmentBox;
  late final Box<ObjectsIdModel> _departmentIdBox;
  late final Box<ObjectModel> _objectIdBox;

  CollectionLocalDatasourceImpl(this.store) {
    _departmentBox = store.box<DepartmentModel>();
    _departmentIdBox = store.box<ObjectsIdModel>();
    _objectIdBox = store.box<ObjectModel>();
  }

  @override
  Future<List<DepartmentModel>> getDepartments() async {
    return _departmentBox.getAll();
  }

  @override
  Future<void> saveDepartments(List<DepartmentModel> departments) async {
    _departmentBox.removeAll();
    _departmentBox.putMany(departments);
  }

  @override
  Future<ObjectsIdModel?> getObjectsByDepartmentId({required int departmentId}) async {
    return _departmentIdBox.query(DepartmentIdModel_.id.equals(departmentId)).build().findFirst();
  }

  @override
  Future<void> saveObjectsByDepartmentId(ObjectsIdModel departmentIdModel) async {
    // Aynı departmentId'ye sahip eski kaydı sil
    final old = _departmentIdBox.query(DepartmentIdModel_.id.equals(departmentIdModel.id)).build().findFirst();
    if (old != null) {
      _departmentIdBox.remove(old.id);
    }
    _departmentIdBox.put(departmentIdModel);
  }

  @override
  Future<ObjectModel?> getObjectDetails({required int objectId}) async {
    return _objectIdBox.query(ObjectIdModel_.id.equals(objectId)).build().findFirst();
  }

  @override
  Future<void> saveObjectDetails(ObjectModel objectIdModel) async {
    // Aynı objectId'ye sahip eski kaydı sil
    final old = _objectIdBox.query(ObjectIdModel_.id.equals(objectIdModel.id)).build().findFirst();
    if (old != null) {
      _objectIdBox.remove(old.id);
    }
    _objectIdBox.put(objectIdModel);
  }
}
