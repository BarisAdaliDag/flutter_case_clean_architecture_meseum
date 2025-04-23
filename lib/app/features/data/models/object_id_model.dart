import 'package:equatable/equatable.dart';

class ObjectIdModel extends Equatable {
  final int departmentIds;
  final String primaryImageSmall;
  final String culture;
  final String department;
  final String title;
  final String objectName;

  const ObjectIdModel({
    required this.departmentIds,
    required this.primaryImageSmall,
    required this.culture,
    required this.department,
    required this.title,
    required this.objectName,
  });

  factory ObjectIdModel.fromJson(Map<String, dynamic> json) {
    return ObjectIdModel(
      departmentIds: json['objectID'] as int,
      primaryImageSmall: json['primaryImageSmall'] as String,
      culture: json['culture'] as String,
      department: json['department'] as String,
      title: json['title'] as String,
      objectName: json['objectName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectID': departmentIds,
      'primaryImageSmall': primaryImageSmall,
      'culture': culture,
      'department': department,
      'title': title,
      'objectName': objectName,
    };
  }

  @override
  List<Object?> get props => [
        departmentIds,
        primaryImageSmall,
        culture,
        department,
        title,
        objectName,
      ];
}
