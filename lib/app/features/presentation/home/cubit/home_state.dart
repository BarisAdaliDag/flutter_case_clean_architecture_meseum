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
  final int famousTotal; // Yeni: Ünlü eserlerin toplam sayısı
  final int currentTotal; // Yeni: Güncel sergilerin toplam sayısı

  const HomeState({
    this.isLoading = false,
    this.errorMessage,
    this.famousObjectsIdModel,
    this.currentObjectsIdModel,
    this.famousArtworkList = const [],
    this.currentList = const [],
    this.famousTotal = 0,
    this.currentTotal = 0,
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
      ];
}
