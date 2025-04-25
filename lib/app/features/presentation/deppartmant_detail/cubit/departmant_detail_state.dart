import 'package:equatable/equatable.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';

import '../../../data/models/test_model.dart';

final class DepartmentDetailState extends Equatable {
  final bool isLoading;
  final List<ObjectModel> objectList;
  final String searchText;
  final List<ObjectModel> filteredObjectList;
  final ObjectsIdModel objectsIdModel;

  const DepartmentDetailState({
    required this.isLoading,
    required this.objectList,
    this.searchText = '',
    List<ObjectModel>? filteredObjectList,
    required this.objectsIdModel,
  }) : filteredObjectList = filteredObjectList ?? objectList;

  DepartmentDetailState copyWith({
    bool? isLoading,
    List<ObjectModel>? objectList,
    String? searchText,
    List<ObjectModel>? filteredObjectList,
    ObjectsIdModel? objectsIdModel,
  }) {
    return DepartmentDetailState(
      isLoading: isLoading ?? this.isLoading,
      objectList: objectList ?? this.objectList,
      searchText: searchText ?? this.searchText,
      filteredObjectList: filteredObjectList ?? this.filteredObjectList,
      objectsIdModel: objectsIdModel ?? this.objectsIdModel,
    );
  }

  @override
  List<Object> get props => [
        isLoading,
        objectList,
        searchText,
        filteredObjectList,
        objectsIdModel,
      ];
}
