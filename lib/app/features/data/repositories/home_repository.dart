import 'package:flutter/foundation.dart';
import 'package:metropolitan_museum/app/features/data/datasources/remote/home_remote_datasource.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/logger/app_logger.dart';
import 'package:metropolitan_museum/core/result/result.dart';

import '../datasources/local/home_local_datasource.dart';

abstract class HomeRepository {
  Future<DataResult<ObjectsIdModel>> getObjectsIdQuery({required String query});
  Future<DataResult<ObjectModel>> getObjectDetails({required int objectId});
  Future<DataResult<ObjectsIdModel?>> getObjectsIdQueryLocal({required String query});
  Future<DataResult<ObjectModel?>> getObjectDetailsLocal({required int objectId});
  Future<void> saveObjectsIdQueryLocal(ObjectsIdModel objectsIdModel, String query);
  Future<void> saveObjectDetailsLocal(ObjectModel objectModel);
  Future<void> debugPrintAllObjectsId();
  Future<void> clearAllData();
}

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource _remoteDatasource;
  final HomeLocalDatasource _localDatasource;

  HomeRepositoryImpl({
    required HomeRemoteDatasource remoteDatasource,
    required HomeLocalDatasource localDatasource,
  })  : _remoteDatasource = remoteDatasource,
        _localDatasource = localDatasource;

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

  @override
  Future<DataResult<ObjectsIdModel?>> getObjectsIdQueryLocal({required String query}) async {
    try {
      final objectsIdModel = await _localDatasource.getObjectsIdQuery(query: query);
      debugPrint('Fetched local ObjectsIdModel for query: $query, Result: $objectsIdModel');
      return SuccessDataResult(data: objectsIdModel, message: "$runtimeType getObjectsIdQueryLocal()");
    } catch (e) {
      AppLogger.instance.error("$runtimeType getObjectsIdQueryLocal() $e");
      return ErrorDataResult(message: "$runtimeType getObjectsIdQueryLocal() $e");
    }
  }

  @override
  Future<DataResult<ObjectModel?>> getObjectDetailsLocal({required int objectId}) async {
    try {
      final objectDetail = await _localDatasource.getObjectDetails(objectId: objectId);
      debugPrint('Fetched local ObjectModel for objectId: $objectId, Result: $objectDetail');
      return SuccessDataResult(data: objectDetail, message: "$runtimeType getObjectDetailsLocal()");
    } catch (e) {
      AppLogger.instance.error("$runtimeType getObjectDetailsLocal() $e");
      return ErrorDataResult(message: "$runtimeType getObjectDetailsLocal() $e");
    }
  }

  @override
  Future<void> saveObjectsIdQueryLocal(ObjectsIdModel objectsIdModel, String query) async {
    await _localDatasource.saveObjectsIdQuery(objectsIdModel, query);
    debugPrint('Saved ObjectsIdModel for query: $query');
  }

  @override
  Future<void> saveObjectDetailsLocal(ObjectModel objectModel) async {
    await _localDatasource.saveObjectDetails(objectModel);
    debugPrint('Saved ObjectModel for objectId: ${objectModel.objectID}');
  }

  @override
  Future<void> debugPrintAllObjectsId() async {
    await _localDatasource.debugPrintAllObjectsId();
  }

  @override
  Future<void> clearAllData() async {
    await _localDatasource.clearAllData();
  }
}
