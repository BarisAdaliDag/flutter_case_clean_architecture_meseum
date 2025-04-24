import 'package:metropolitan_museum/app/features/data/datasources/remote/home_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/logger/app_logger.dart';
import 'package:metropolitan_museum/core/result/result.dart';

abstract class HomeRepository {
  Future<DataResult<ObjectsIdModel>> getObjectsIdQuery({required String query});
  Future<DataResult<ObjectModel>> getObjectDetails({required int objectId});
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _remoteDatasource;

  HomeRepositoryImpl({required HomeRemoteDatasource remoteDatasource}) : _remoteDatasource = remoteDatasource;

  @override
  Future<DataResult<ObjectsIdModel>> getObjectsIdQuery({required String query}) async {
    final apiResponseModel = await _remoteDatasource.getObjectsIdQuery(query: query);
    if (!apiResponseModel.isSuccess) {
      AppLogger.instance.error(
          "$runtimeType getObjectsIdQuery() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
      return ErrorDataResult(
          message:
              "$runtimeType getObjectsIdQuery() ${apiResponseModel.error?.message ?? ""} Status code: ${apiResponseModel.error?.statusCode}");
    }
    if (apiResponseModel.data == null) {
      AppLogger.instance.error("$runtimeType getObjectsIdQuery() Null Data");
      return ErrorDataResult(message: "$runtimeType getObjectsIdQuery() Null Data");
    }
    AppLogger.instance.log("$runtimeType getObjectsIdQuery() SUCCESS");
    return SuccessDataResult(data: apiResponseModel.data!, message: "$runtimeType getObjectsIdQuery()");
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
}
