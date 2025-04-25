import 'package:metropolitan_museum/app/features/data/models/test_model.dart';
import 'package:metropolitan_museum/core/logger/app_logger.dart';

abstract class TestLocalDatasource {
  Future<ObjectTestModel> getById({
    required String id,
  });
}

class TestLocalDatasourceImpl implements TestLocalDatasource {
  @override
  Future<ObjectTestModel> getById({
    required String id,
  }) {
    AppLogger.instance.error("Error");
    throw UnimplementedError();
  }
}
