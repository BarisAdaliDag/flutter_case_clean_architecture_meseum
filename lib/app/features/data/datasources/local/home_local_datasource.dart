import 'package:flutter/foundation.dart';
import 'package:metropolitan_museum/app/common/service/object_box_service.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

import '../../../../../objectbox.g.dart';

abstract class HomeLocalDatasource {
  Future<void> saveObjectsIdQuery(ObjectsIdModel objectsIdModel, String query);
  Future<ObjectsIdModel?> getObjectsIdQuery({required String query});
  Future<void> saveObjectDetails(ObjectModel objectModel);
  Future<ObjectModel?> getObjectDetails({required int objectId});
  Future<void> debugPrintAllObjectsId();
  Future<void> clearAllData();
}

class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final ObjectBoxService _objectBoxService;
  late final Box<ObjectsIdModel> _objectsIdBox;
  late final Box<ObjectModel> _objectBox;

  HomeLocalDatasourceImpl(this._objectBoxService) {
    _objectsIdBox = _objectBoxService.objectsIdBox;
    _objectBox = _objectBoxService.objectBox;
  }

  @override
  Future<void> saveObjectsIdQuery(ObjectsIdModel objectsIdModel, String query) async {
    final existing = _objectsIdBox.query(ObjectsIdModel_.query.equals(query)).build().findFirst();
    if (existing != null) {
      objectsIdModel.id = existing.id; // Var olan ID'yi koru
    }
    objectsIdModel.query = query; // Query alanını set et
    _objectsIdBox.put(objectsIdModel);
    debugPrint('Saved ObjectsIdModel for query: $query');
  }

  @override
  Future<ObjectsIdModel?> getObjectsIdQuery({required String query}) async {
    final result = _objectsIdBox.query(ObjectsIdModel_.query.equals(query)).build().findFirst();
    debugPrint('Local ObjectsIdModel for query $query: $result');
    return result;
  }

  @override
  Future<void> saveObjectDetails(ObjectModel objectModel) async {
    final existing = _objectBox.query(ObjectModel_.objectID.equals(objectModel.objectID!)).build().findFirst();
    if (existing != null) {
      objectModel.id = existing.id; // Var olan ID'yi koru
    }
    _objectBox.put(objectModel);
    debugPrint('Saved ObjectModel for objectId: ${objectModel.objectID}');
  }

  @override
  Future<ObjectModel?> getObjectDetails({required int objectId}) async {
    final result = _objectBox.query(ObjectModel_.objectID.equals(objectId)).build().findFirst();
    debugPrint('Local ObjectModel for objectId $objectId: $result');
    return result;
  }

  @override
  Future<void> debugPrintAllObjectsId() async {
    final allObjects = _objectsIdBox.getAll();
    debugPrint('All ObjectsIdModel in database: $allObjects');
  }

  @override
  Future<void> clearAllData() async {
    _objectsIdBox.removeAll();
    _objectBox.removeAll();
    debugPrint('Cleared all local data for Home');
  }
}
