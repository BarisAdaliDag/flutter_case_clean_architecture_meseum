import 'package:metropolitan_museum/app/common/config/config.dart';
import 'package:metropolitan_museum/app/features/data/models/test_model.dart';
import 'package:metropolitan_museum/core/dio_manager/api_response_model.dart';
import 'package:metropolitan_museum/core/dio_manager/dio_manager.dart';

abstract class TestRemoteDatasource {
  Future<ApiResponseModel<ObjectModel>> getById({
    required String id,
  });
  Future<ApiResponseModel<List<ObjectModel>>> getAll();
  Future<ApiResponseModel<void>> create({
    required ObjectModel testModel,
  });
}

final class TestRemoteDatasourceImpl implements TestRemoteDatasource {
  final DioApiManager _dioApiManager = DioApiManager(baseUrl: Config.apiBaseUrl);
  @override
  Future<ApiResponseModel<void>> create({
    required ObjectModel testModel,
  }) async {
    var apiResponseModel = await _dioApiManager.post('/create', data: testModel.toMap());
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<List<ObjectModel>>> getAll() async {
    var apiResponseModel = await _dioApiManager.get(
      '/getAll',
      converter: (data) => (data as List).map((e) => ObjectModel.fromMap(e)).toList(),
    );
    return apiResponseModel;
  }

  @override
  Future<ApiResponseModel<ObjectModel>> getById({
    required String id,
  }) async {
    var apiResponseModel = await _dioApiManager.get(
      '/get',
      converter: (data) => ObjectModel.fromMap(data),
      data: {'id': id},
    );
    return apiResponseModel;
  }
}
