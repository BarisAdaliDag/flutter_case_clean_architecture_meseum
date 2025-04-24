import 'package:metropolitan_museum/core/dio_manager/api_response_model.dart';
import 'package:metropolitan_museum/core/dio_manager/dio_manager.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/department_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_id_model.dart';

import '../../../../../core/errors/exceptions.dart';

abstract class HomeRemoteDatasource {
  Future<ApiResponseModel<DepartmentsModel>> getDepartments();
  Future<ApiResponseModel<DepartmentIdModel>> getObjectsByDepartmentId({
    required int departmentId,
  });
  Future<ApiResponseModel<ObjectIdModel>> getObjectDetails({
    required int objectId,
  });
}

final class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
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
  Future<ApiResponseModel<DepartmentIdModel>> getObjectsByDepartmentId({
    required int departmentId,
  }) async {
    try {
      final response = await _dioApiManager.get(
        '/objects?departmentIds=$departmentId',
        converter: (data) => DepartmentIdModel.fromJson(data),
      );
      return response;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<ApiResponseModel<ObjectIdModel>> getObjectDetails({
    required int objectId,
  }) async {
    try {
      final response = await _dioApiManager.get(
        '/objects/$objectId',
        converter: (data) => ObjectIdModel.fromJson(data),
      );
      return response;
    } catch (e) {
      throw ServerException();
    }
  }
}
