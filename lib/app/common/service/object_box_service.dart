import 'package:objectbox/objectbox.dart';
import '../../../objectbox.g.dart';
import '../../features/data/models/object_model.dart';
import '../../features/data/models/objects_id_model.dart';

class ObjectBoxService {
  late final Store store;
  late final Box<ObjectsIdModel> objectsIdBox;
  late final Box<ObjectModel> objectBox;

  ObjectBoxService._create(this.store) {
    objectsIdBox = Box<ObjectsIdModel>(store);
    objectBox = Box<ObjectModel>(store);
  }

  static Future<ObjectBoxService> create() async {
    final store = await openStore();
    return ObjectBoxService._create(store);
  }

  // Kapatma metodu (opsiyonel, uygulama kapanırken çağrılabilir)
  void close() {
    store.close();
  }
}
