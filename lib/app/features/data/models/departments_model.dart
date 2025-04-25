import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DepartmentsModel extends Equatable {
  @Id()
  int id = 0;
  final List<DepartmentModel> departments;

  DepartmentsModel({this.id = 0, required this.departments});

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

@Entity()
class DepartmentModel extends Equatable {
  @Id()
  int id = 0;
  final int departmentId;
  final String displayName;

  DepartmentModel({
    this.id = 0,
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
