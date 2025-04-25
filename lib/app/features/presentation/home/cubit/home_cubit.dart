import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/data/repositories/home_repository.dart';
import 'package:metropolitan_museum/app/features/data/models/objects_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_model.dart';
import 'package:metropolitan_museum/core/network_control/network_control.dart';
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
    print('Fetching data for query: $query, isFamous: $isFamous, start: $start, end: $end');
    // State'i sıfırla
    emit(HomeState(
      isLoading: true,
      errorMessage: null,
      famousObjectsIdModel: isFamous ? null : state.famousObjectsIdModel,
      currentObjectsIdModel: !isFamous ? null : state.currentObjectsIdModel,
      famousArtworkList: isFamous ? [] : state.famousArtworkList,
      currentList: !isFamous ? [] : state.currentList,
    ));

    // Veritabanı içeriğini kontrol et
    await homeRepository.debugPrintAllObjectsId();

    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    final bool hasInternet = networkResult == NetworkResult.on;

    ObjectsIdModel? objectsIdModel;
    List<ObjectModel> details = [];

    if (hasInternet) {
      // Online veri çekme
      final result = await homeRepository.getObjectsIdQuery(query: query);
      print('Online fetch for query: $query, Result: $result');
      if (result is SuccessDataResult<ObjectsIdModel> && result.data != null) {
        objectsIdModel = result.data!;
        await homeRepository.saveObjectsIdQueryLocal(objectsIdModel, query);
        print('Saved ObjectsIdModel for query: $query, Total IDs: ${objectsIdModel.objectIDs.length}');

        final ids = objectsIdModel.objectIDs.sublist(
          start,
          end > objectsIdModel.objectIDs.length ? objectsIdModel.objectIDs.length : end,
        );
        for (final id in ids) {
          final detailResult = await homeRepository.getObjectDetails(objectId: id);
          if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
            details.add(detailResult.data!);
            await homeRepository.saveObjectDetailsLocal(detailResult.data!);
            print('Saved ObjectModel for objectId: $id');
          }
        }
      } else {
        print('Online fetch failed for query: $query, Error: ${result.message}');
      }
    }

    // Çevrimdışı veri çekme
    if (objectsIdModel == null) {
      final localResult = await homeRepository.getObjectsIdQueryLocal(query: query);
      print('Local fetch for query: $query, Result: $localResult');
      if (localResult is SuccessDataResult<ObjectsIdModel?> && localResult.data != null) {
        objectsIdModel = localResult.data!;
      } else {
        emit(HomeState(
          isLoading: false,
          errorMessage: 'No object or Offline Network-1',
          famousObjectsIdModel: isFamous ? null : state.famousObjectsIdModel,
          currentObjectsIdModel: !isFamous ? null : state.currentObjectsIdModel,
          famousArtworkList: isFamous ? [] : state.famousArtworkList,
          currentList: !isFamous ? [] : state.currentList,
        ));
        print('No local data for query: $query');
        return;
      }
    }

    final ids = objectsIdModel.objectIDs.sublist(
      start,
      end > objectsIdModel.objectIDs.length ? objectsIdModel.objectIDs.length : end,
    );
    for (final id in ids) {
      final localDetailResult = await homeRepository.getObjectDetailsLocal(objectId: id);
      print('Local object fetch for objectId: $id, Result: $localDetailResult');
      if (localDetailResult is SuccessDataResult<ObjectModel?> && localDetailResult.data != null) {
        details.add(localDetailResult.data!);
      }
    }

    emit(HomeState(
      isLoading: false,
      famousObjectsIdModel: isFamous ? objectsIdModel : state.famousObjectsIdModel,
      currentObjectsIdModel: !isFamous ? objectsIdModel : state.currentObjectsIdModel,
      famousArtworkList: isFamous ? details : state.famousArtworkList,
      currentList: !isFamous ? details : state.currentList,
      errorMessage: details.isEmpty ? 'No object or Offline Network .' : null,
    ));
    print('Emitted state for query: $query, Details count: ${details.length}');
  }

  Future<void> fetchHomeData() async {
    print('Fetching home data');
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
