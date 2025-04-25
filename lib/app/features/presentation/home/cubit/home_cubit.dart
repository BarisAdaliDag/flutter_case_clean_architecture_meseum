import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/data/repositories/home_repository.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/result/result.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository}) : super(const HomeState());

  Future<void> fetchObjectList({
    required String query,
    required bool isFamous,
    required int start,
    required int end,
  }) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    final result = await homeRepository.getObjectsIdQuery(query: query);
    if (result is SuccessDataResult<ObjectsIdModel> && result.data != null) {
      final objectsIdModel = result.data!;
      final ids = objectsIdModel.objectIDs.sublist(
        start,
        end > objectsIdModel.objectIDs.length ? objectsIdModel.objectIDs.length : end,
      );
      List<ObjectModel> details = [];
      for (final id in ids) {
        final detailResult = await homeRepository.getObjectDetails(objectId: id);
        if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
          details.add(detailResult.data!);
        }
      }
      emit(state.copyWith(
        isLoading: false,
        famousObjectsIdModel: isFamous ? objectsIdModel : state.famousObjectsIdModel,
        famousArtworkList: isFamous ? details : state.famousArtworkList,
        currentObjectsIdModel: !isFamous ? objectsIdModel : state.currentObjectsIdModel,
        currentList: !isFamous ? details : state.currentList,
        errorMessage: null,
      ));
    } else {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: result.message ?? 'Bir hata oluştu',
      ));
    }
  }

  Future<void> fetchHomeData() async {
    await fetchObjectList(
      query: "Current%20Exhibitions",
      isFamous: false,
      start: 0,
      end: 4,
    );
    await fetchObjectList(
      query: "Famous%20Artworks",
      isFamous: true,
      start: 0,
      end: 4,
    );
  }
}
