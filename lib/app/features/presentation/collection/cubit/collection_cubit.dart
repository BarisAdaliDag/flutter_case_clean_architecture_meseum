import 'package:flutter/material.dart';
import 'package:metropolitan_museum/core/network_control/network_control.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/result/result.dart';
import 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepository collectionRepository;
  final TextEditingController searchController = TextEditingController();

  CollectionCubit({required this.collectionRepository})
      : super(const CollectionState(
          isLoading: false,
          departmentList: [],
          objectList: [],
          departmentIdModels: [],
          searchText: '',
          filteredDepartmentList: [],
        )) {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    search(searchController.text);
  }

  void search(String query) {
    final filtered =
        state.departmentList.where((d) => d.displayName.toLowerCase().contains(query.toLowerCase())).toList();
    emit(state.copyWith(
      searchText: query,
      filteredDepartmentList: filtered,
    ));
  }

  @override
  Future<void> close() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    return super.close();
  }

  Future<void> loadDepartments() async {
    emit(state.copyWith(isLoading: true));
    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    final bool hasInternet = networkResult == NetworkResult.on;
    List<DepartmentModel> departments = [];
    if (hasInternet) {
      final departmentsResult = await collectionRepository.getDepartments();
      if (departmentsResult is SuccessDataResult<DepartmentsModel> && departmentsResult.data != null) {
        departments = departmentsResult.data!.departments;
        await collectionRepository.saveDepartmentsLocal(departments);
      } else {
        final localResult = await collectionRepository.getDepartmentsLocal();
        if (localResult is SuccessDataResult<List<DepartmentModel>> && localResult.data != null) {
          departments = localResult.data!;
        }
      }
    } else {
      final localResult = await collectionRepository.getDepartmentsLocal();
      if (localResult is SuccessDataResult<List<DepartmentModel>> && localResult.data != null) {
        departments = localResult.data!;
      }
    }
    emit(state.copyWith(
      isLoading: false,
      departmentList: departments,
      filteredDepartmentList: departments,
    ));
  }

  Future<void> loadObjects() async {
    emit(state.copyWith(isLoading: true));
    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    final bool hasInternet = networkResult == NetworkResult.on;
    final departments = state.departmentList;
    List<List<ObjectModel>> allObjects = [];
    List<ObjectsIdModel> allDepartmentIdModels = [];
    for (final department in departments) {
      ObjectsIdModel? departmentIdModel;
      if (hasInternet) {
        final objectsResult =
            await collectionRepository.getObjectsByDepartmentId(departmentId: department.departmentId);
        if (objectsResult is SuccessDataResult<ObjectsIdModel> && objectsResult.data != null) {
          departmentIdModel = objectsResult.data!;
          await collectionRepository.saveObjectsByDepartmentIdLocal(departmentIdModel);
          final objectIds = departmentIdModel.objectIDs.take(5).toList();
          for (final objectId in objectIds) {
            final detailResult = await collectionRepository.getObjectDetails(objectId: objectId);
            if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
              await collectionRepository.saveObjectDetailsLocal(detailResult.data!);
            }
          }
        }
      }
      departmentIdModel ??=
          (await collectionRepository.getObjectsByDepartmentIdLocal(departmentId: department.departmentId)).data;
      if (departmentIdModel == null) {
        allObjects.add([]);
        allDepartmentIdModels.add(ObjectsIdModel(objectIDs: const [], total: 0));
        continue;
      }
      allDepartmentIdModels.add(departmentIdModel);
      final objectIds = departmentIdModel.objectIDs.take(5).toList();
      List<ObjectModel> objectDetails = [];
      for (final objectId in objectIds) {
        ObjectModel? objectDetail;
        if (hasInternet) {
          final detailResult = await collectionRepository.getObjectDetails(objectId: objectId);
          if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
            objectDetail = detailResult.data!;
            await collectionRepository.saveObjectDetailsLocal(objectDetail);
          }
        }
        objectDetail ??= (await collectionRepository.getObjectDetailsLocal(objectId: objectId)).data;
        if (objectDetail != null) {
          objectDetails.add(objectDetail);
        }
      }
      allObjects.add(objectDetails);
    }
    emit(state.copyWith(isLoading: false, objectList: allObjects, departmentIdModels: allDepartmentIdModels));
  }

  Future<void> loadDepartmentsAndObjects() async {
    await loadDepartments();
  }
}
