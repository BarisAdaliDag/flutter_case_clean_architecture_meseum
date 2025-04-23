import 'package:equatable/equatable.dart';

class DepartmentsModel extends Equatable {
  final List<DepartmentModel> departments;

  const DepartmentsModel({required this.departments});

  factory DepartmentsModel.fromJson(Map<String, dynamic> json) {
    return DepartmentsModel(
      departments: (json['departments'] as List<dynamic>).map((e) => DepartmentModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departments': departments.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [departments];
}

class DepartmentModel extends Equatable {
  final int departmentId;
  final String displayName;

  const DepartmentModel({
    required this.departmentId,
    required this.displayName,
  });

  factory DepartmentModel.fromJson(Map<String, dynamic> json) {
    return DepartmentModel(
      departmentId: json['departmentId'],
      displayName: json['displayName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'departmentId': departmentId,
      'displayName': displayName,
    };
  }

  @override
  List<Object?> get props => [departmentId, displayName];
}
