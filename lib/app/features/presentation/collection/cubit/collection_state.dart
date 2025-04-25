import 'package:equatable/equatable.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';

class CollectionState extends Equatable {
  final bool isLoading;
  final List<DepartmentModel> departmentList;
  final String searchText;
  final List<DepartmentModel> filteredDepartmentList;
  final String? error;

  const CollectionState({
    required this.isLoading,
    required this.departmentList,
    required this.searchText,
    required this.filteredDepartmentList,
    this.error,
  });

  CollectionState copyWith({
    bool? isLoading,
    List<DepartmentModel>? departmentList,
    String? searchText,
    List<DepartmentModel>? filteredDepartmentList,
    String? error,
  }) {
    return CollectionState(
      isLoading: isLoading ?? this.isLoading,
      departmentList: departmentList ?? this.departmentList,
      searchText: searchText ?? this.searchText,
      filteredDepartmentList: filteredDepartmentList ?? departmentList ?? this.filteredDepartmentList,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        departmentList,
        searchText,
        filteredDepartmentList,
        error,
      ];
}
