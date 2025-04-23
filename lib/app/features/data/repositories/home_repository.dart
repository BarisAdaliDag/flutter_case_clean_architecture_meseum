import 'package:metropolitan_museum/app/features/data/datasources/remote/home_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/department_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_id_model.dart';
import 'package:metropolitan_museum/core/logger/app_logger.dart';
import 'package:metropolitan_museum/core/result/result.dart';

abstract class HomeRepository {
  Future<DataResult<DepartmentsModel>> getDepartments();
  Future<DataResult<DepartmentIdModel>> getObjectsByDepartmentId({required int departmentId});
  Future<DataResult<ObjectIdModel>> getObjectDetails({required int objectId});
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _remoteDatasource;

  HomeRepositoryImpl({
    required HomeRemoteDatasource remoteDatasource,
  }) : _remoteDatasource = remoteDatasource;

  @override
  Future<DataResult<DepartmentsModel>> getDepartments() async {
    final apiResponseModel = await _remoteDatasource.getDepartments();
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType getDepartments() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorDataResult(
          message:
              "$runtimeType getDepartments() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getDepartments() Null Data");
      return ErrorDataResult(message: "$runtimeType getDepartments() Null Data");
    }
    AppLogger.instance.log("$runtimeType getDepartments() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!, message: "$runtimeType getDepartments()");
  }

  @override
  Future<DataResult<DepartmentIdModel>> getObjectsByDepartmentId({required int departmentId}) async {
    final apiResponseModel = await _remoteDatasource.getObjectsByDepartmentId(departmentId: departmentId);
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType getObjectsByDepartmentId() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorDataResult(
          message:
              "$runtimeType getObjectsByDepartmentId() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getObjectsByDepartmentId() Null Data");
      return ErrorDataResult(message: "$runtimeType getObjectsByDepartmentId() Null Data");
    }
    AppLogger.instance.log("$runtimeType getObjectsByDepartmentId() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!, message: "$runtimeType getObjectsByDepartmentId()");
  }

  @override
  Future<DataResult<ObjectIdModel>> getObjectDetails({required int objectId}) async {
    final apiResponseModel = await _remoteDatasource.getObjectDetails(objectId: objectId);
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType getObjectDetails() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorDataResult(
          message:
              "$runtimeType getObjectDetails() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getObjectDetails() Null Data");
      return ErrorDataResult(message: "$runtimeType getObjectDetails() Null Data");
    }
    AppLogger.instance.log("$runtimeType getObjectDetails() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!, message: "$runtimeType getObjectDetails()");
  }
}
