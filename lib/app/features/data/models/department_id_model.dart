import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class DepartmentIdModel extends Equatable {
  @Id()
  int id = 0; // ObjectBox için gerekli
  final int total;
  final List<int> objectIDs;

  DepartmentIdModel({
    this.id = 0,
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
