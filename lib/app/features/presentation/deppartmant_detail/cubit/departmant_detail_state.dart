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
  final int currentPage; // Yeni: Mevcut sayfa
  final int itemsPerPage; // Yeni: Sayfa başına obje sayısı
  final int totalItems; // Yeni: Toplam obje sayısı

  const DepartmentDetailState({
    required this.isLoading,
    required this.objectList,
    this.searchText = '',
    List<ObjectModel>? filteredObjectList,
    required this.objectsIdModel,
    this.error = '',
    this.currentPage = 1, // Varsayılan: 1. sayfa
    this.itemsPerPage = 20, // HomeCubit ile uyumlu
    this.totalItems = 0, // Varsayılan: 0
  }) : filteredObjectList = filteredObjectList ?? objectList;

  DepartmentDetailState copyWith({
    bool? isLoading,
    List<ObjectModel>? objectList,
    String? searchText,
    List<ObjectModel>? filteredObjectList,
    ObjectsIdModel? objectsIdModel,
    String? error,
    int? currentPage,
    int? itemsPerPage,
    int? totalItems,
  }) {
    return DepartmentDetailState(
      isLoading: isLoading ?? this.isLoading,
      objectList: objectList ?? this.objectList,
      searchText: searchText ?? this.searchText,
      filteredObjectList: filteredObjectList ?? this.filteredObjectList,
      objectsIdModel: objectsIdModel ?? this.objectsIdModel,
      error: error ?? this.error,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
      totalItems: totalItems ?? this.totalItems,
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
        currentPage,
        itemsPerPage,
        totalItems,
      ];
}
