import 'package:metropolitan_museum/core/dio_manager/api_response_model.dart';
import 'package:metropolitan_museum/core/dio_manager/dio_manager.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

import '../../../../../core/errors/exceptions.dart';
import '../../../../common/config/config.dart';

abstract class HomeRemoteDatasource {
  Future<ApiResponseModel<ObjectsIdModel>> getObjectsIdQuery({required String query});
  Future<ApiResponseModel<ObjectModel>> getObjectDetails({
    required int objectId,
  });
}

final class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final DioApiManager _dioApiManager = DioApiManager(
    baseUrl: Config.apiBaseUrl,
  );

  @override
  Future<ApiResponseModel<ObjectsIdModel>> getObjectsIdQuery({
    required String query,
  }) async {
    try {
      final response = await _dioApiManager.get(
        '/search?q=$query',
        converter: (data) => ObjectsIdModel.fromJson(data, departmentId: 0),
      );
      return response;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ApiResponseModel<ObjectModel>> getObjectDetails({
    required int objectId,
  }) async {
    try {
      final response = await _dioApiManager.get(
        '/objects/$objectId',
        converter: (data) => ObjectModel.fromJson(data),
      );
      return response;
    } catch (e) {
      throw ServerException();
    }
  }
}
