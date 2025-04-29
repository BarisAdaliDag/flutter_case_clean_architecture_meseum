// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class DepartmentsModel extends Equatable {
  @Id()
  int id = 0;

  final departments = ToMany<DepartmentModel>(); // List yerine ToMany

  DepartmentsModel();

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) {
    final model = DepartmentsModel();
    final List<dynamic> departmentsJson = json['departments'] ?? [];
    model.departments.addAll(
      departmentsJson.map((e) => DepartmentModel.fromJson(e)).toList(),
    );
    return model;
  }

  Map<String, dynamic> toJson() {
    return {
      'departments': departments.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, departments];
}

@Entity()
class DepartmentModel extends Equatable {
  @Id()
  int id = 0;

  final int departmentId;
  final String displayName;

  DepartmentModel({
    required this.departmentId,
    required this.displayName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departmentId: json['departmentId'] ?? 0,
      displayName: json['displayName'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departmentId': departmentId,
      'displayName': displayName,
    };
  }

  @override
  List<Object?> get props => [id, departmentId, displayName];
}
