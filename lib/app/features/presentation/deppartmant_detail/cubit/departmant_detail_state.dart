import 'package:equatable/equatable.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';

final class DepartmentDetailState extends Equatable {
  final bool isLoading;
  final List<ObjectModel> objectList;
  final String searchText;
  final List<ObjectModel> filteredObjectList;
  final ObjectsIdModel objectsIdModel;
  final String error;

  const DepartmentDetailState({
    required this.isLoading,
    required this.objectList,
    this.searchText = '',
    List<ObjectModel>? filteredObjectList,
    required this.objectsIdModel,
    this.error = '',
  }) : filteredObjectList = filteredObjectList ?? objectList;

  DepartmentDetailState copyWith({
    bool? isLoading,
    List<ObjectModel>? objectList, // Nullable type
    String? searchText,
    List<ObjectModel>? filteredObjectList,
    ObjectsIdModel? objectsIdModel,
    String? error,
  }) {
    return DepartmentDetailState(
      isLoading: isLoading ?? this.isLoading,
      objectList: objectList ?? this.objectList,
      searchText: searchText ?? this.searchText,
      filteredObjectList: filteredObjectList ?? this.filteredObjectList,
      objectsIdModel: objectsIdModel ?? this.objectsIdModel,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        objectList,
        searchText,
        filteredObjectList,
        objectsIdModel,
        error,
      ];
}
