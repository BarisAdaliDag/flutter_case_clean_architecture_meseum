import 'package:equatable/equatable.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';

class HomeState extends Equatable {
  final bool isLoading;
  final ObjectsIdModel? famousObjectsIdModel;
  final ObjectsIdModel? currentObjectsIdModel;

  final String? errorMessage;
  final List<ObjectModel> currentList;
  final List<ObjectModel> famousArtworkList;

  const HomeState({
    this.isLoading = false,
    this.famousObjectsIdModel,
    this.currentObjectsIdModel,
    this.errorMessage,
    this.currentList = const [],
    this.famousArtworkList = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    ObjectsIdModel? famousObjectsIdModel,
    ObjectsIdModel? currentObjectsIdModel,
    ObjectModel? objectModel,
    String? errorMessage,
    List<ObjectModel>? currentList,
    List<ObjectModel>? famousArtworkList,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      famousObjectsIdModel: famousObjectsIdModel ?? famousObjectsIdModel,
      errorMessage: errorMessage ?? this.errorMessage,
      currentList: currentList ?? this.currentList,
      famousArtworkList: famousArtworkList ?? this.famousArtworkList,
      currentObjectsIdModel: currentObjectsIdModel ?? this.currentObjectsIdModel,
    );
  }

  @override
  List<Object?> get props =>
      [isLoading, famousObjectsIdModel, errorMessage, currentList, famousArtworkList, currentObjectsIdModel];
}
