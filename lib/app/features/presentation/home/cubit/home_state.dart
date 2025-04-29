import 'package:equatable/equatable.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final String? errorMessage;
  final ObjectsIdModel? famousObjectsIdModel;
  final ObjectsIdModel? currentObjectsIdModel;
  final List<ObjectModel> famousArtworkList;
  final List<ObjectModel> currentList;
  final int famousTotal;
  final int currentTotal;
  final int famousCurrentPage;
  final int currentExhibitionsCurrentPage;
  final int itemsPerPage;

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.famousObjectsIdModel,
    this.currentObjectsIdModel,
    this.famousArtworkList = const [],
    this.currentList = const [],
    this.famousTotal = 0,
    this.currentTotal = 0,
    this.famousCurrentPage = 1,
    this.currentExhibitionsCurrentPage = 1,
    this.itemsPerPage = 20, // SeeAllMixin'den alındı
  });

  HomeState copyWith({
    bool? isLoading,
    String? errorMessage,
    ObjectsIdModel? famousObjectsIdModel,
    ObjectsIdModel? currentObjectsIdModel,
    List<ObjectModel>? famousArtworkList,
    List<ObjectModel>? currentList,
    int? famousTotal,
    int? currentTotal,
    int? famousCurrentPage,
    int? currentExhibitionsCurrentPage,
    int? itemsPerPage,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      famousObjectsIdModel: famousObjectsIdModel ?? this.famousObjectsIdModel,
      currentObjectsIdModel: currentObjectsIdModel ?? this.currentObjectsIdModel,
      famousArtworkList: famousArtworkList ?? this.famousArtworkList,
      currentList: currentList ?? this.currentList,
      famousTotal: famousTotal ?? this.famousTotal,
      currentTotal: currentTotal ?? this.currentTotal,
      famousCurrentPage: famousCurrentPage ?? this.famousCurrentPage,
      currentExhibitionsCurrentPage: currentExhibitionsCurrentPage ?? this.currentExhibitionsCurrentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        errorMessage,
        famousObjectsIdModel,
        currentObjectsIdModel,
        famousArtworkList,
        currentList,
        famousTotal,
        currentTotal,
        famousCurrentPage,
        currentExhibitionsCurrentPage,
        itemsPerPage,
      ];
}
