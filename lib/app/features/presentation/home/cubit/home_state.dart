import 'package:equatable/equatable.dart';
import 'package:metropolitan_museum/app/features/data/models/departments_model.dart';
import 'package:metropolitan_museum/app/features/data/models/department_id_model.dart';
import 'package:metropolitan_museum/app/features/data/models/object_id_model.dart';

final class HomeState extends Equatable {
  final bool isLoading;
  final List<DepartmentModel> departmentList;
  final List<List<ObjectIdModel>> objectList; // Her department için 5 obje
  final List<DepartmentIdModel> departmentIdModels; // Her department için ayrı DepartmentIdModel

  const HomeState({
    required this.isLoading,
    required this.departmentList,
    required this.objectList,
    this.departmentIdModels = const [],
  });

  HomeState copyWith({
    bool? isLoading,
    List<DepartmentModel>? departmentList,
    List<List<ObjectIdModel>>? objectList,
    List<DepartmentIdModel>? departmentIdModels,
  }) {
    return HomeState(
      isLoading: isLoading ?? this.isLoading,
      departmentList: departmentList ?? this.departmentList,
      objectList: objectList ?? this.objectList,
      departmentIdModels: departmentIdModels ?? this.departmentIdModels,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        departmentList,
        objectList,
        departmentIdModels,
      ];
}
