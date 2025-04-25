import 'package:metropolitan_museum/core/dio_manager/api_response_model.dart';
import 'package:metropolitan_museum/core/dio_manager/dio_manager.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

import '../../../../../core/errors/exceptions.dart';

abstract class CollectionRemoteDatasource {
  Future<ApiResponseModel<DepartmentsModel>> getDepartments();
  Future<ApiResponseModel<ObjectsIdModel>> getObjectsByDepartmentId({
    required int departmentId,
  });
  Future<ApiResponseModel<ObjectModel>> getObjectDetails({
    required int objectId,
  });
}

final class CollectionRemoteDatasourceImpl implements CollectionRemoteDatasource {
  final DioApiManager _dioApiManager = DioApiManager(
    baseUrl: 'https://collectionapi.metmuseum.org/public/collection/v1',
  );

  @override
  Future<ApiResponseModel<DepartmentsModel>> getDepartments() async {
    try {
      final response = await _dioApiManager.get(
        '/departments',
        converter: (data) => DepartmentsModel.fromJson(data),
      );
      return response;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ApiResponseModel<ObjectsIdModel>> getObjectsByDepartmentId({
    required int departmentId,
  }) async {
    try {
      final response = await _dioApiManager.get(
        '/objects?departmentIds=$departmentId',
        converter: (data) {
          print('API Response for departmentId $departmentId: $data');
          return ObjectsIdModel.fromJson(data, departmentId: departmentId);
        },
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
