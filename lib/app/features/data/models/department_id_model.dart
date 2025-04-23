import 'package:equatable/equatable.dart';

class DepartmentIdModel extends Equatable {
  final int total;
  final List<int> objectIDs;

  const DepartmentIdModel({
    required this.total,
    required this.objectIDs,
  });

  factory DepartmentIdModel.fromJson(Map<String, dynamic> json) {
    return DepartmentIdModel(
      total: json['total'],
      objectIDs: List<int>.from(json['objectIDs'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'objectIDs': objectIDs,
    };
  }

  @override
  List<Object?> get props => [total, objectIDs];
}
