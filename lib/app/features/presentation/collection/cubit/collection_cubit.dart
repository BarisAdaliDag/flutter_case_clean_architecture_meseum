import 'package:flutter/material.dart';
import 'package:metropolitan_museum/core/network_control/network_control.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/result/result.dart';
import 'collection_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/core/network_control/network_control.dart';
import 'package:metropolitan_museum/app/features/data/repositories/collection_repository.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/core/result/result.dart';
import 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  final CollectionRepository collectionRepository;
  final TextEditingController searchController = TextEditingController();

  CollectionCubit({required this.collectionRepository})
      : super(const CollectionState(
          isLoading: false,
          departmentList: [],
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
    List<DepartmentModel> departments = [];

    final hasInternet = await NetworkControl().checkNetworkFirstTime() == NetworkResult.on;
    if (hasInternet) {
      final result = await collectionRepository.getDepartments();
      if (result is SuccessDataResult<DepartmentsModel> && result.data != null) {
        departments = result.data!.departments;
        await collectionRepository.saveDepartmentsLocal(departments);
      }
    }

    if (!hasInternet) {
      final localResult = await collectionRepository.getDepartmentsLocal();
      if (localResult is SuccessDataResult<List<DepartmentModel>> && localResult.data != null) {
        departments = localResult.data!;
      }
    }

    emit(state.copyWith(
      isLoading: false,
      departmentList: departments,
      filteredDepartmentList: departments,
      error: departments.isEmpty ? 'Departmanlar yüklenemedi' : null,
    ));
  }
}
