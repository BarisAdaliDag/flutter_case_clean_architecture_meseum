import 'package:metropolitan_museum/core/network_control/network_control.dart';
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

  Future<void> loadDepartments() async {
    emit(state.copyWith(isLoading: true));
    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    final bool hasInternet = networkResult == NetworkResult.on;
    List<DepartmentModel> departments = [];
    if (hasInternet) {
      final departmentsResult = await homeRepository.getDepartments();
      if (departmentsResult is SuccessDataResult<DepartmentsModel> && departmentsResult.data != null) {
        departments = departmentsResult.data!.departments;
        await homeRepository.saveDepartmentsLocal(departments);
      } else {
        final localResult = await homeRepository.getDepartmentsLocal();
        if (localResult is SuccessDataResult<List<DepartmentModel>> && localResult.data != null) {
          departments = localResult.data!;
        }
      }
    } else {
      final localResult = await homeRepository.getDepartmentsLocal();
      if (localResult is SuccessDataResult<List<DepartmentModel>> && localResult.data != null) {
        departments = localResult.data!;
      }
    }
    departments = departments.take(3).toList();
    emit(state.copyWith(isLoading: false, departmentList: departments));
  }

  Future<void> loadObjects() async {
    emit(state.copyWith(isLoading: true));
    final networkControl = NetworkControl();
    final networkResult = await networkControl.checkNetworkFirstTime();
    final bool hasInternet = networkResult == NetworkResult.on;
    final departments = state.departmentList;
    List<List<ObjectIdModel>> allObjects = [];
    List<DepartmentIdModel> allDepartmentIdModels = [];
    for (final department in departments) {
      DepartmentIdModel? departmentIdModel;
      if (hasInternet) {
        final objectsResult = await homeRepository.getObjectsByDepartmentId(departmentId: department.departmentId);
        if (objectsResult is SuccessDataResult<DepartmentIdModel> && objectsResult.data != null) {
          departmentIdModel = objectsResult.data!;
          await homeRepository.saveObjectsByDepartmentIdLocal(departmentIdModel);
          final objectIds = departmentIdModel.objectIDs.take(5).toList();
          for (final objectId in objectIds) {
            final detailResult = await homeRepository.getObjectDetails(objectId: objectId);
            if (detailResult is SuccessDataResult<ObjectIdModel> && detailResult.data != null) {
              await homeRepository.saveObjectDetailsLocal(detailResult.data!);
            }
          }
        }
      }
      departmentIdModel ??=
          (await homeRepository.getObjectsByDepartmentIdLocal(departmentId: department.departmentId)).data;
      if (departmentIdModel == null) {
        allObjects.add([]);
        allDepartmentIdModels.add(DepartmentIdModel(objectIDs: const [], total: 0));
        continue;
      }
      allDepartmentIdModels.add(departmentIdModel);
      final objectIds = departmentIdModel.objectIDs.take(5).toList();
      List<ObjectIdModel> objectDetails = [];
      for (final objectId in objectIds) {
        ObjectIdModel? objectDetail;
        if (hasInternet) {
          final detailResult = await homeRepository.getObjectDetails(objectId: objectId);
          if (detailResult is SuccessDataResult<ObjectIdModel> && detailResult.data != null) {
            objectDetail = detailResult.data!;
            await homeRepository.saveObjectDetailsLocal(objectDetail);
          }
        }
        objectDetail ??= (await homeRepository.getObjectDetailsLocal(objectId: objectId)).data;
        if (objectDetail != null) {
          objectDetails.add(objectDetail);
        }
      }
      allObjects.add(objectDetails);
    }
    emit(state.copyWith(isLoading: false, objectList: allObjects, departmentIdModels: allDepartmentIdModels));
  }

  Future<void> loadDepartmentsAndObjects() async {
    await loadDepartments();
    await loadObjects();
  }
}
