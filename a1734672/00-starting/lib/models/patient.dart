import 'package:flutter/foundation.dart';

class Patient {
  final String patientId;
  final String age;
  final String FirstName;
  final String LastName;
  final String weight;
  final String height;
  final String userId;

  Patient({
    @required this.userId,
    @required this.patientId,
    this.FirstName,
    this.LastName,
    this.age,
    this.height,
    this.weight,
  });

  Map<String, dynamic> toMap() {
    return {
      'FirstName': FirstName,
      'patientId': patientId,
      'LastName': LastName,
      'age': age,
      'height': height,
      'weight': weight,
      'userId': userId,
    };
  }

  static Patient fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Patient(
        userId: map['userId'],
        patientId: map['patientId'],
        LastName: map['LastName'],
        FirstName: map['FirstName'],
        height: map['height'],
        age: map['age'],
        weight: map['weight']);
  }
}
