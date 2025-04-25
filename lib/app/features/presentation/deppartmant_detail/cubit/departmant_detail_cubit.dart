import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';
import 'package:metropolitan_museum/app/features/presentation/deppartmant_detail/cubit/departmant_detail_state.dart';
import 'package:metropolitan_museum/core/result/result.dart';

final class DepartmentDetailCubit extends Cubit<DepartmentDetailState> {
  final CollectionRepository collectionRepository;
  final TextEditingController searchController = TextEditingController();

  DepartmentDetailCubit({required this.collectionRepository})
      : super(DepartmentDetailState(
          isLoading: false,
          objectsIdModel: ObjectsIdModel(objectIDs: const [], total: 0),
          objectList: const [],
          searchText: '',
        )) {
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    search(searchController.text);
  }

  void search(String query) {
    final objectList = state.objectList;

    final filtered = objectList.where((d) => d.title!.toLowerCase().contains(query.toLowerCase())).toList();
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

  Future<void> loadListCollection(int departmentId) async {
    emit(state.copyWith(isLoading: true));
    final objectsResult = await collectionRepository.getObjectsByDepartmentId(departmentId: departmentId);
    if (objectsResult is SuccessDataResult<ObjectsIdModel> && objectsResult.data != null) {
      final departmentIdModel = objectsResult.data!;
      final objectIds = departmentIdModel.objectIDs.take(5).toList();
      List<ObjectModel> objectDetails = [];
      for (final objectId in objectIds) {
        final detailResult = await collectionRepository.getObjectDetails(objectId: objectId);
        if (detailResult is SuccessDataResult<ObjectModel?> && detailResult.data != null) {
          objectDetails.add(detailResult.data!);
        }
      }
      print(objectDetails);
      emit(state.copyWith(
        isLoading: false,
        objectList: objectDetails as List<ObjectModel>?,
        objectsIdModel: departmentIdModel,
        filteredObjectList: objectDetails as List<ObjectModel>?,
      ));
    } else {
      emit(state.copyWith(isLoading: false));
    }
  }
}
