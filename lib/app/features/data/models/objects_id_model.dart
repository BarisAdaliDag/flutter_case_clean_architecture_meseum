import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class ObjectsIdModel extends Equatable {
  @Id()
  int id = 0;

  final int total;
  final List<int> objectIDs;
  final int departmentId;
  String? query; // Yeni alan

  ObjectsIdModel({
    required this.total,
    required this.objectIDs,
    required this.departmentId,
    this.query,
  });

  factory ObjectsIdModel.fromJson(Map<String, dynamic> json, {required int departmentId, String? query}) {
    return ObjectsIdModel(
      total: json['total'] ?? 0,
      objectIDs: List<int>.from(json['objectIDs'] ?? []),
      departmentId: departmentId,
      query: query,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': total,
      'objectIDs': objectIDs,
      'departmentId': departmentId,
      'query': query,
    };
  }

  @override
  List<Object?> get props => [id, total, objectIDs, departmentId, query];
}
