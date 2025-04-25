import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';

import '../../../../../core/network_control/network_control.dart';
import '../../../data/models/objects_id_model.dart';
import 'departmant_detail_state.dart';

import 'package:bloc/bloc.dart';

final class DepartmentDetailCubit extends Cubit<DepartmentDetailState> {
  final CollectionRepository collectionRepository;
  final TextEditingController searchController = TextEditingController();

  DepartmentDetailCubit({required this.collectionRepository})
      : super(DepartmentDetailState(
          isLoading: false,
          objectsIdModel: ObjectsIdModel(objectIDs: const [], total: 0),
          objectList: const [],
          filteredObjectList: const [],
          searchText: '',
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

  // Future<void> loadObjects() async {
  //   emit(state.copyWith(isLoading: true));
  //   final networkControl = NetworkControl();
  //   final networkResult = await networkControl.checkNetworkFirstTime();
  //   final bool hasInternet = networkResult == NetworkResult.on;
  //   final departments = state.departmentList;
  //   List<List<ObjectModel>> allObjects = [];
  //   List<ObjectsIdModel> allDepartmentIdModels = [];
  //   for (final department in departments) {
  //     ObjectsIdModel? departmentIdModel;
  //     if (hasInternet) {
  //       final objectsResult =
  //           await collectionRepository.getObjectsByDepartmentId(departmentId: department.departmentId);
  //       if (objectsResult is SuccessDataResult<ObjectsIdModel> && objectsResult.data != null) {
  //         departmentIdModel = objectsResult.data!;
  //         await collectionRepository.saveObjectsByDepartmentIdLocal(departmentIdModel);
  //         final objectIds = departmentIdModel.objectIDs.take(5).toList();
  //         for (final objectId in objectIds) {
  //           final detailResult = await collectionRepository.getObjectDetails(objectId: objectId);
  //           if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
  //             await collectionRepository.saveObjectDetailsLocal(detailResult.data!);
  //           }
  //         }
  //       }
  //     }
  //     departmentIdModel ??=
  //         (await collectionRepository.getObjectsByDepartmentIdLocal(departmentId: department.departmentId)).data;
  //     if (departmentIdModel == null) {
  //       allObjects.add([]);
  //       allDepartmentIdModels.add(ObjectsIdModel(objectIDs: const [], total: 0));
  //       continue;
  //     }
  //     allDepartmentIdModels.add(departmentIdModel);
  //     final objectIds = departmentIdModel.objectIDs.take(5).toList();
  //     List<ObjectModel> objectDetails = [];
  //     for (final objectId in objectIds) {
  //       ObjectModel? objectDetail;
  //       if (hasInternet) {
  //         final detailResult = await collectionRepository.getObjectDetails(objectId: objectId);
  //         if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
  //           objectDetail = detailResult.data!;
  //           await collectionRepository.saveObjectDetailsLocal(objectDetail);
  //         }
  //       }
  //       objectDetail ??= (await collectionRepository.getObjectDetailsLocal(objectId: objectId)).data;
  //       if (objectDetail != null) {
  //         objectDetails.add(objectDetail);
  //       }
  //     }
  //     allObjects.add(objectDetails);
  //   }
  //   emit(state.copyWith(isLoading: false, objectList: allObjects, departmentIdModels: allDepartmentIdModels));
  // }

  Future<void> loadObjects() async {
    emit(state.copyWith(isLoading: true));
    // }
    //  await loadObjects();
  }
}
