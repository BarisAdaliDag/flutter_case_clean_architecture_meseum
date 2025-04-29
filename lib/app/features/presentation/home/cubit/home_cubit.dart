
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
    int? page, // Yeni: Belirli bir sayfa için veri çek
  }) async {
    final currentPage =
        page ?? (isFamous ? state.famousCurrentPage : state.currentExhibitionsCurrentPage); // Varsayılan: Mevcut sayfa
    final start = (currentPage - 1) * state.itemsPerPage;
    final end = currentPage * state.itemsPerPage;

    emit(state.copyWith(
      isLoading: true,
      errorMessage: null,
      famousCurrentPage: isFamous ? currentPage : state.famousCurrentPage,
      currentExhibitionsCurrentPage: !isFamous ? currentPage : state.currentExhibitionsCurrentPage,
    ));

    final bool hasInternet = await checkInternetControl();
    ObjectsIdModel? objectsIdModel;
    List<ObjectModel> details = isFamous ? List.from(state.famousArtworkList) : List.from(state.currentList);

    if (hasInternet) {
      objectsIdModel = await _fetchOnlineObjects(query, start, end, details);
    } else {
      objectsIdModel = await _fetchOfflineObjects(query, details);
    }

    if (objectsIdModel == null) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Bu koleksiyon için veri bulunamadı.',
      ));
      return;
    }

    emit(state.copyWith(
      isLoading: false,
      famousObjectsIdModel: isFamous ? objectsIdModel : state.famousObjectsIdModel,
      currentObjectsIdModel: !isFamous ? objectsIdModel : state.currentObjectsIdModel,
      famousArtworkList: isFamous ? details : state.famousArtworkList,
      currentList: !isFamous ? details : state.currentList,
      famousTotal: isFamous ? objectsIdModel.total : state.famousTotal,
      currentTotal: !isFamous ? objectsIdModel.total : state.currentTotal,
      famousCurrentPage: isFamous ? currentPage : state.famousCurrentPage,
      currentExhibitionsCurrentPage: !isFamous ? currentPage : state.currentExhibitionsCurrentPage,
      errorMessage: details.isEmpty ? 'Bu koleksiyon için obje bulunamadı.' : null,
    ));
  }

  Future<ObjectsIdModel?> _fetchOnlineObjects(String query, int start, int end, List<ObjectModel> details) async {
    final result = await homeRepository.getObjectsIdQuery(query: query);
    if (result is! SuccessDataResult<ObjectsIdModel> || result.data == null) {
      return null;
    }
    final objectsIdModel = result.data!;
    await homeRepository.saveObjectsIdQueryLocal(objectsIdModel, query);
    final ids = objectsIdModel.objectIDs.sublist(
      start,
      end > objectsIdModel.objectIDs.length ? objectsIdModel.objectIDs.length : end,
    );
    for (final id in ids) {
      final detailResult = await homeRepository.getObjectDetails(objectId: id);
      if (detailResult is SuccessDataResult<ObjectModel> && detailResult.data != null) {
        details.add(detailResult.data!);
        await homeRepository.saveObjectDetailsLocal(detailResult.data!);
      }
    }
    return objectsIdModel;
  }

  Future<ObjectsIdModel?> _fetchOfflineObjects(String query, List<ObjectModel> details) async {
    final localResult = await homeRepository.getObjectsIdQueryLocal(query: query);
    if (localResult is! SuccessDataResult<ObjectsIdModel?> || localResult.data == null) {
      return null;
    }
    final objectsIdModel = localResult.data!;
    for (final id in objectsIdModel.objectIDs) {
      final localDetailResult = await homeRepository.getObjectDetailsLocal(objectId: id);
      if (localDetailResult is SuccessDataResult<ObjectModel?> && localDetailResult.data != null) {
        details.add(localDetailResult.data!);
      }
    }
    return objectsIdModel;
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
      page: 1,
    );
    await fetchObjectList(
      query: "Famous%20Artworks",
      isFamous: true,
      page: 1,
    );
  }

  void nextPage({required bool isFamous}) {
    final totalItems = isFamous ? state.famousTotal : state.currentTotal;
    final totalPages = (totalItems / state.itemsPerPage).ceil();
    final currentPage = isFamous ? state.famousCurrentPage : state.currentExhibitionsCurrentPage;

    if (currentPage < totalPages) {
      print('Navigating to next page: ${currentPage + 1} / $totalPages');
      fetchObjectList(
        query: isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
        isFamous: isFamous,
        page: currentPage + 1,
      );
    }
  }

  void previousPage({required bool isFamous}) {
    final currentPage = isFamous ? state.famousCurrentPage : state.currentExhibitionsCurrentPage;
    if (currentPage > 1) {
      print('Navigating to previous page: ${currentPage - 1}');
      fetchObjectList(
        query: isFamous ? "Famous%20Artworks" : "Current%20Exhibitions",
        isFamous: isFamous,
        page: currentPage - 1,
      );
    }
  }

  resetCurrentlist() {
    emit(state.copyWith(
      currentList: [],
      currentTotal: 0,
      currentExhibitionsCurrentPage: 1, // Sıfırlarken sayfa 1'e dönsün
    ));
  }

  resetfamouslist() {
    emit(state.copyWith(
      famousArtworkList: [],
      famousTotal: 0,
      famousCurrentPage: 1, // Sıfırlarken sayfa 1'e dönsün
    ));
  }
}
