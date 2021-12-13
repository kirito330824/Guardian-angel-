import 'package:flutter/foundation.dart';

class Logbook {
  final String title;
  final String imageUrl;
  final String userId;
  final String documentId;
  final String PatientName;
  final String imageFileName;

  Logbook({
    @required this.userId,
    @required this.title,
    this.PatientName,
    this.documentId,
    this.imageUrl,
    this.imageFileName,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'imageUrl': imageUrl,
      'imageFileName': imageFileName,
      'PatientName': PatientName,
    };
  }

  static Logbook fromMap(Map<String, dynamic> map, String documentId) {
    if (map == null) return null;

    return Logbook(
      title: map['title'],
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      imageFileName: map['imageFileName'],
      documentId: documentId,
    );
  }
}
