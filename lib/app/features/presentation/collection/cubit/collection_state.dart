import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

final class CollectionState extends Equatable {
  final bool isLoading;
  final List<DepartmentModel> departmentList;
  final List<List<ObjectModel>> objectList; // Her department için 5 obje
  final List<ObjectsIdModel> departmentIdModels; // Her department için ayrı DepartmentIdModel
  final String searchText;
  final List<DepartmentModel> filteredDepartmentList;

  const CollectionState({
    required this.isLoading,
    required this.departmentList,
    required this.objectList,
    this.departmentIdModels = const [],
    this.searchText = '',
    List<DepartmentModel>? filteredDepartmentList,
  }) : filteredDepartmentList = filteredDepartmentList ?? departmentList;

  CollectionState copyWith({
    bool? isLoading,
    List<DepartmentModel>? departmentList,
    List<List<ObjectModel>>? objectList,
    List<ObjectsIdModel>? departmentIdModels,
    String? searchText,
    List<DepartmentModel>? filteredDepartmentList,
  }) {
    return CollectionState(
      isLoading: isLoading ?? this.isLoading,
      departmentList: departmentList ?? this.departmentList,
      objectList: objectList ?? this.objectList,
      departmentIdModels: departmentIdModels ?? this.departmentIdModels,
      searchText: searchText ?? this.searchText,
      filteredDepartmentList: filteredDepartmentList ?? this.filteredDepartmentList,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        departmentList,
        objectList,
        departmentIdModels,
        searchText,
        filteredDepartmentList,
      ];
}
