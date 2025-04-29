import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
// ignore: must_be_immutable
class ObjectModel extends Equatable {
  @Id()
  int id = 0;
  final int? objectID;
  final String? category;
  final String? culture; // Nullable type local
  final String? primaryImageSmall;
  final String? objectDate;
  final String? title;
  final String? department;
  final String? country;
  final String? region;
  final String? objectName;
  final String? creditLine;
  final String? accessionNumber;
  final String? dimensions;
  final String? medium;
  final String? geographyType;
  final String? classification;

  ObjectModel({
    this.id = 0,
    required this.objectID,
    this.category,
    required this.primaryImageSmall,
    required this.culture,
    required this.department,
    required this.title,
    required this.objectName,
    this.country,
    this.region,
    this.creditLine,
    this.accessionNumber,
    this.dimensions,
    this.medium,
    this.geographyType,
    this.classification,
    this.objectDate,
  });

  factory ObjectModel.fromJson(Map<String, dynamic> json) {
    return ObjectModel(
      objectID: json['objectID'] as int?,
      category: null,
      primaryImageSmall: json['primaryImageSmall'] as String?,
      culture: json['culture'] as String?,
      department: json['department'] as String?,
      title: json['title'] as String?,
      objectName: json['objectName'] as String?,
      country: json['country'] as String?,
      region: json['region'] as String?,
      creditLine: json['creditLine'] as String?,
      accessionNumber: json['accessionNumber'] as String?,
      dimensions: json['dimensions'] as String?,
      medium: json['medium'] as String?,
      geographyType: json['geographyType'] as String?,
      classification: json['classification'] as String?,
      objectDate: json['objectDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'objectID': objectID,
      'category': category,
      'primaryImageSmall': primaryImageSmall,
      'culture': culture,
      'department': department,
      'title': title,
      'objectName': objectName,
      'country': country,
      'region': region,
      'creditLine': creditLine,
      'accessionNumber': accessionNumber,
      'dimensions': dimensions,
      'medium': medium,
      'geographyType': geographyType,
      'classification': classification,
      'objectDate': objectDate,
    };
  }

  @override
  List<Object?> get props => [
        objectID,
        category,
        primaryImageSmall,
        culture,
        department,
        title,
        objectName,
        country,
        region,
        creditLine,
        accessionNumber,
        dimensions,
        medium,
        geographyType,
        classification,
        objectDate,
      ];
}
