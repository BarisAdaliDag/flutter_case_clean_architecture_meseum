// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

class ObjectTestModel extends Equatable {
  String? id;
  String? title;
  int? count;
  bool? hasTest;

  ObjectTestModel({
    this.id,
    this.title,
    this.count,
    this.hasTest,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'count': count,
      'hasTest': hasTest,
    };
  }

  factory ObjectTestModel.fromMap(Map<String, dynamic> map) {
    return ObjectTestModel(
      id: map['id'] != null ? map['id'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      count: map['count'] != null ? map['count'] as int : null,
      hasTest: map['hasTest'] != null ? map['hasTest'] as bool : null,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        count,
        hasTest,
      ];
}
