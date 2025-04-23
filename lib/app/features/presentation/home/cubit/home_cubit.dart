import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metropolitan_museum/app/features/data/repositories/home_repository.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/department_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_id_model.dart';
import 'package:metropolitan_museum/core/result/result.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository homeRepository;

  HomeCubit({required this.homeRepository})
      : super(const HomeState(
          isLoading: false,
          departmentList: [],
          objectList: [],
          departmentIdModels: [],
        ));

  Future<void> loadDepartmentsAndObjects() async {
    emit(state.copyWith(isLoading: true));

    // 1. Departmanları çek
    final departmentsResult = await homeRepository.getDepartments();
    if (departmentsResult is! SuccessDataResult<DepartmentsModel>) {
      emit(state.copyWith(isLoading: false));
      return;
    }
    final departments = departmentsResult.data?.departments ?? [];

    // 2. Her departman için ilk 5 objeyi ve DepartmentIdModel'i çek
    List<List<ObjectIdModel>> allObjects = [];
    List<DepartmentIdModel> allDepartmentIdModels = [];
    for (final department in departments) {
      final objectsResult = await homeRepository.getObjectsByDepartmentId(departmentId: department.departmentId);
      if (objectsResult is! SuccessDataResult<DepartmentIdModel> || objectsResult.data == null) {
        allObjects.add([]);
        allDepartmentIdModels.add(const DepartmentIdModel(objectIDs: [], total: 0)); // total parametresi eklendi
        continue;
      }
      allDepartmentIdModels.add(objectsResult.data!);
      final objectIds = objectsResult.data!.objectIDs.take(5).toList();

      List<ObjectIdModel> objectDetails = [];
      for (final objectId in objectIds) {
        final detailResult = await homeRepository.getObjectDetails(objectId: objectId);
        if (detailResult is SuccessDataResult<ObjectIdModel> && detailResult.data != null) {
          objectDetails.add(detailResult.data!);
        }
      }
      allObjects.add(objectDetails);
    }

    emit(state.copyWith(
      isLoading: false,
      departmentList: departments,
      objectList: allObjects,
      departmentIdModels: allDepartmentIdModels,
    ));
  }
}
