import 'package:metropolitan_museum/app/common/service/object_box_service.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/objectbox.g.dart';

abstract class CollectionLocalDatasource {
  Future<List<DepartmentModel>> getDepartments();
  Future<ObjectsIdModel?> getObjectsByDepartmentId({required int departmentId});
  Future<ObjectModel?> getObjectDetails({required int objectId});
  Future<void> saveDepartments(List<DepartmentModel> departments);
  Future<void> saveObjectsByDepartmentId(ObjectsIdModel departmentIdModel);
  Future<void> saveObjectDetails(ObjectModel objectIdModel);
}

class CollectionLocalDatasourceImpl implements CollectionLocalDatasource {
  final ObjectBoxService _objectBoxService;
  late final Box<DepartmentModel> _departmentBox;
  late final Box<ObjectsIdModel> _departmentIdBox;
  late final Box<ObjectModel> _objectIdBox;

  CollectionLocalDatasourceImpl(this._objectBoxService) {
    _departmentBox = _objectBoxService.departmentBox;
    _departmentIdBox = _objectBoxService.objectsIdBox;
    _objectIdBox = _objectBoxService.objectBox;
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
    return _departmentIdBox.query(ObjectsIdModel_.departmentId.equals(departmentId)).build().findFirst();
  }

  @override
  Future<void> saveObjectsByDepartmentId(ObjectsIdModel departmentIdModel) async {
    print('Saving ObjectsIdModel for departmentId: ${departmentIdModel.departmentId}');
    final existing =
        _departmentIdBox.query(ObjectsIdModel_.departmentId.equals(departmentIdModel.departmentId)).build().findFirst();
    if (existing != null) {
      departmentIdModel.id = existing.id; // Var olan ID'yi koru
    }
    _departmentIdBox.put(departmentIdModel);
  }

  @override
  Future<ObjectModel?> getObjectDetails({required int objectId}) async {
    return _objectIdBox.query(ObjectModel_.objectID.equals(objectId)).build().findFirst();
  }

  @override
  Future<void> saveObjectDetails(ObjectModel objectIdModel) async {
    final existing = _objectIdBox.query(ObjectModel_.objectID.equals(objectIdModel.objectID!)).build().findFirst();
    if (existing != null) {
      objectIdModel.id = existing.id; // Var olan ID'yi koru
    }
    _objectIdBox.put(objectIdModel);
  }
}
