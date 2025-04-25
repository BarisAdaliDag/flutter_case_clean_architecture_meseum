import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ObjectsIdModel extends Equatable {
  @Id()
  int id = 0; // ObjectBox için gerekli
  final int total;
  final List<int> objectIDs;
  final int departmentId; // Yeni alan

  ObjectsIdModel({
    this.id = 0,
    required this.total,
    required this.objectIDs,
    required this.departmentId,
  });

  factory ObjectsIdModel.fromJson(Map<String, dynamic> json, {required int departmentId}) {
    return ObjectsIdModel(
      total: json['total'],
      objectIDs: List<int>.from(json['objectIDs'] ?? []),
      departmentId: departmentId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'objectIDs': objectIDs,
      'departmentId': departmentId,
    };
  }

  @override
  List<Object?> get props => [total, objectIDs, departmentId];
}
