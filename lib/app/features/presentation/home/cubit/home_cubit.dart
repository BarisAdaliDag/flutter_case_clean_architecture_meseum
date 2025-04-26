import 'dart:math';

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
    // Yükleme durumunu güncelle
    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
    ));

    // Veritabanı içeriğini kontrol et
    // await homeRepository.debugPrintAllObjectsId();

    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    bool hasInternet = await checkInternetControl();

    ObjectsIdModel? objectsIdModel;
    List<ObjectModel> details = isFamous ? List.from(state.famousArtworkList) : List.from(state.currentList);

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
        int succesx = 0;
        int failx = 0;
        for (final id in ids) {
          final detailResult = await homeRepository.getObjectDetails(objectId: id);
          if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
            details.add(detailResult.data!);
            await homeRepository.saveObjectDetailsLocal(detailResult.data!);
            print('Saved ObjectModel for objectId: $id');
            succesx++;
          } else {
            failx++;
            print('Failed to fetch object details for objectId: $id, Error: ${detailResult.message}');
          }
        }
        print('Fetched object details for query: $query, Success: $succesx, Fail: $failx');
      } else {
        print('Online fetch failed for query: $query, Error: ${result.message}');
      }
    }

    // Çevrimdışı veri çekme
    if (objectsIdModel == null || hasInternet == false) {
      final localResult = await homeRepository.getObjectsIdQueryLocal(query: query);
      print('Local fetch for query: $query, Result: $localResult');
      if (localResult is SuccessDataResult<ObjectsIdModel?> && localResult.data != null) {
        objectsIdModel = localResult.data!;
      } else {
        emit(state.copyWith(
          isLoading: false,
          errorMessage: 'Bu koleksiyon için çevrimdışı veri bulunamadı.',
        ));
        print('No local data for query: $query');
        return;
      }
    }
    if (!hasInternet) {
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
    }

    emit(state.copyWith(
      isLoading: false,
      famousObjectsIdModel: isFamous ? objectsIdModel : state.famousObjectsIdModel,
      currentObjectsIdModel: !isFamous ? objectsIdModel : state.currentObjectsIdModel,
      famousArtworkList: isFamous ? details : state.famousArtworkList,
      currentList: !isFamous ? details : state.currentList,
      famousTotal: isFamous ? objectsIdModel.total : state.famousTotal,
      currentTotal: !isFamous ? objectsIdModel.total : state.currentTotal,
      errorMessage: details.isEmpty ? 'Bu koleksiyon için obje bulunamadı.' : null,
    ));
    print('Emitted state for query: $query, Details count: ${details.length}, Total: ${objectsIdModel.total}');
  }

  Future<bool> checkInternetControl() async {
    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    final bool hasInternet = networkResult == NetworkResult.on;
    return hasInternet;
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

  resetCurrentlist() {
    emit(state.copyWith(
      currentList: [],
      currentTotal: 0,
    ));
  }

  resetfamouslist() {
    emit(state.copyWith(
      famousArtworkList: [],
      currentTotal: 0,
    ));
  }
}
