import 'package:metropolitan_museum/app/features/data/datasources/local/collection_local_datasource.dart';
import 'package:metropolitan_museum/app/features/data/datasources/remote/collection_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/logger/app_logger.dart';
import 'package:metropolitan_museum/core/result/result.dart';

abstract class CollectionRepository {
  Future<DataResult<DepartmentsModel>> getDepartments();
  Future<DataResult<ObjectsIdModel>> getObjectsByDepartmentId({required int departmentId});
  Future<DataResult<ObjectModel>> getObjectDetails({required int objectId});
  // Local kaynaklardan veri çekmek için eklenen methodlar
  Future<DataResult<List<DepartmentModel>>> getDepartmentsLocal();
  Future<DataResult<ObjectsIdModel?>> getObjectsByDepartmentIdLocal({required int departmentId});
  Future<DataResult<ObjectModel?>> getObjectDetailsLocal({required int objectId});
  Future<void> saveDepartmentsLocal(List<DepartmentModel> departments);
  Future<void> saveObjectsByDepartmentIdLocal(ObjectsIdModel departmentIdModel);
  Future<void> saveObjectDetailsLocal(ObjectModel objectIdModel);
}

class CollectionRepositoryImpl implements CollectionRepository {
  final CollectionRemoteDatasource _remoteDatasource;
  final CollectionLocalDatasource _localDatasource;

  CollectionRepositoryImpl({
    required CollectionRemoteDatasource remoteDatasource,
    required CollectionLocalDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

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
  Future<DataResult<ObjectsIdModel>> getObjectsByDepartmentId({required int departmentId}) async {
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
  Future<DataResult<ObjectModel>> getObjectDetails({required int objectId}) async {
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

  @override
  Future<DataResult<List<DepartmentModel>>> getDepartmentsLocal() async {
    try {
      final data = await _localDatasource.getDepartments();
      return SuccessDataResult(data: data, message: "Local getDepartments");
    } catch (e) {
      return ErrorDataResult(message: "Local getDepartments error: $e");
    }
  }

  @override
  Future<DataResult<ObjectsIdModel?>> getObjectsByDepartmentIdLocal({required int departmentId}) async {
    try {
      final data = await _localDatasource.getObjectsByDepartmentId(departmentId: departmentId);
      return SuccessDataResult(data: data, message: "Local getObjectsByDepartmentId");
    } catch (e) {
      return ErrorDataResult(message: "Local getObjectsByDepartmentId error: $e");
    }
  }

  @override
  Future<DataResult<ObjectModel?>> getObjectDetailsLocal({required int objectId}) async {
    try {
      final data = await _localDatasource.getObjectDetails(objectId: objectId);
      return SuccessDataResult(data: data, message: "Local getObjectDetails");
    } catch (e) {
      return ErrorDataResult(message: "Local getObjectDetails error: $e");
    }
  }

  @override
  Future<void> saveDepartmentsLocal(List<DepartmentModel> departments) async {
    await _localDatasource.saveDepartments(departments);
  }

  @override
  Future<void> saveObjectsByDepartmentIdLocal(ObjectsIdModel departmentIdModel) async {
    await _localDatasource.saveObjectsByDepartmentId(departmentIdModel);
  }

  @override
  Future<void> saveObjectDetailsLocal(ObjectModel objectIdModel) async {
    await _localDatasource.saveObjectDetails(objectIdModel);
  }
}
