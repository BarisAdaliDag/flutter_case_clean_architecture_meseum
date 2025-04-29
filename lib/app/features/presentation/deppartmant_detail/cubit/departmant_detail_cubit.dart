import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_state.dart';
import 'package:metropolitan_museum/core/result/result.dart';
import '../../../../../core/network_control/network_control.dart';

class DepartmentDetailCubit extends Cubit<DepartmentDetailState> {
  final CollectionRepository collectionRepository;
  final TextEditingController searchController = TextEditingController();

  DepartmentDetailCubit({required this.collectionRepository})
      : super(DepartmentDetailState(
          isLoading: false,
          error: '',
          objectsIdModel: ObjectsIdModel(objectIDs: const [], total: 0, departmentId: 0),
          objectList: const [],
          searchText: '',
          filteredObjectList: const [],
          currentPage: 1,
          itemsPerPage: 20,
          totalItems: 0,
        )) {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    search(searchController.text);
  }

  void search(String query) {
    final filtered = state.objectList.where((d) => d.title!.toLowerCase().contains(query.toLowerCase())).toList();
    emit(state.copyWith(
      searchText: query,
      filteredObjectList: filtered,
    ));
  }

  @override
  Future<void> close() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    return super.close();
  }

  Future<void> loadListCollection({
    required int departmentId,
    int? page,
  }) async {
    final currentPage = page ?? state.currentPage;
    final start = (currentPage - 1) * state.itemsPerPage;
    final end = currentPage * state.itemsPerPage;

    emit(state.copyWith(
      isLoading: true,
      error: '',
      currentPage: currentPage,
      objectList: [],
      filteredObjectList: [],
    ));

    final bool hasInternet = await checkInternetControl();
    ObjectsIdModel? departmentIdModel;
    List<ObjectModel> objectDetails = [];

    if (hasInternet) {
      final result = await _fetchOnlineData(departmentId, start, end);
      departmentIdModel = result.$1;
      objectDetails = result.$2;
    } else {
      final result = await _fetchOfflineData(departmentId, start, end);
      departmentIdModel = result.$1;
      objectDetails = result.$2;
    }

    if (departmentIdModel == null) {
      emit(state.copyWith(
        isLoading: false,
        error: hasInternet
            ? 'Veri alınamadı. Lütfen tekrar deneyin.'
            : 'İnternet bağlantısı yok ve yerel veri bulunamadı.',
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: false,
      objectList: objectDetails,
      objectsIdModel: departmentIdModel,
      filteredObjectList: objectDetails,
      totalItems: departmentIdModel.total,
      error: objectDetails.isEmpty ? 'Bu departman için obje bulunamadı.' : null,
    ));
  }

  Future<(ObjectsIdModel?, List<ObjectModel>)> _fetchOnlineData(int departmentId, int start, int end) async {
    List<ObjectModel> objectDetails = [];
    final objectsResult = await collectionRepository.getObjectsByDepartmentId(departmentId: departmentId);
    if (objectsResult is! SuccessDataResult<ObjectsIdModel> || objectsResult.data == null) {
      return (null, objectDetails);
    }

    final departmentIdModel = objectsResult.data!;
    await collectionRepository.saveObjectsByDepartmentIdLocal(departmentIdModel);
    print('Saved ObjectsIdModel for departmentId: $departmentId');

    final objectIds = departmentIdModel.objectIDs.sublist(
      start,
      end > departmentIdModel.objectIDs.length ? departmentIdModel.objectIDs.length : end,
    );

    for (final objectId in objectIds) {
      final detailResult = await collectionRepository.getObjectDetails(objectId: objectId);
      if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
        objectDetails.add(detailResult.data!);
        await collectionRepository.saveObjectDetailsLocal(detailResult.data!);
      }
    }

    return (departmentIdModel, objectDetails);
  }

  Future<(ObjectsIdModel?, List<ObjectModel>)> _fetchOfflineData(int departmentId, int start, int end) async {
    List<ObjectModel> objectDetails = [];
    final localObjectsResult = await collectionRepository.getObjectsByDepartmentIdLocal(departmentId: departmentId);
    if (localObjectsResult is! SuccessDataResult<ObjectsIdModel?> || localObjectsResult.data == null) {
      return (null, objectDetails);
    }

    final departmentIdModel = localObjectsResult.data!;
    final objectIds = departmentIdModel.objectIDs.sublist(
      start,
      end > departmentIdModel.objectIDs.length ? departmentIdModel.objectIDs.length : end,
    );

    for (final objectId in objectIds) {
      final localDetailResult = await collectionRepository.getObjectDetailsLocal(objectId: objectId);
      if (localDetailResult is SuccessDataResult<ObjectModel?> && localDetailResult.data != null) {
        objectDetails.add(localDetailResult.data!);
      }
    }

    return (departmentIdModel, objectDetails);
  }

  Future<bool> checkInternetControl() async {
    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    return networkResult == NetworkResult.on;
  }

  void nextPage({required int departmentId}) {
    final totalPages = (state.totalItems / state.itemsPerPage).ceil();
    if (state.currentPage < totalPages) {
      print('Navigating to next page: ${state.currentPage + 1} / $totalPages');
      loadListCollection(
        departmentId: departmentId,
        page: state.currentPage + 1,
      );
    }
  }

  void previousPage({required int departmentId}) {
    if (state.currentPage > 1) {
      print('Navigating to previous page: ${state.currentPage - 1}');
      loadListCollection(
        departmentId: departmentId,
        page: state.currentPage - 1,
      );
    }
  }

  void init({required int departmentId}) {
    loadListCollection(departmentId: departmentId, page: 1);
  }
}
