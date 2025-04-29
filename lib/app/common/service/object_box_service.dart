import 'package:flutter/material.dart';

import '../../../objectbox.g.dart';
import '../../features/data/models/object_model.dart';
import '../../features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:path_provider/path_provider.dart';

class ObjectBoxService {
  late final Store store;
  late final Box<ObjectsIdModel> objectsIdBox;
  late final Box<ObjectModel> objectBox;
  late final Box<DepartmentModel> departmentBox;

  ObjectBoxService._create(this.store) {
    objectsIdBox = Box<ObjectsIdModel>(store);
    objectBox = Box<ObjectModel>(store);
    departmentBox = Box<DepartmentModel>(store);
  }

  static Future<ObjectBoxService> create() async {
    debugPrint('ObjectBoxService.create called');
    final dir = await getApplicationDocumentsDirectory();
    final store = await openStore(directory: '${dir.path}/objectbox');
    return ObjectBoxService._create(store);
  }

  void close() {
    store.close();
  }
}
