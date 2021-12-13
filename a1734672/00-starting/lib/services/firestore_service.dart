import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:compound/models/user.dart';
import 'package:compound/models/Logbook.dart';
import 'package:compound/models/patient.dart';
import 'package:flutter/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');

  final CollectionReference _logbooksCollectionReference =
      Firestore.instance.collection('logbooks');

  final StreamController<List<Logbook>> _logbooksController =
      StreamController<List<Logbook>>.broadcast();

  final CollectionReference _patientsCollectionReference =
      Firestore.instance.collection('Patients');

  final StreamController<List<Patient>> _patientsController =
      StreamController<List<Patient>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.massage;
    }
  }

  Future addLogbooks(Logbook logbook) async {
    try {
      await _logbooksCollectionReference.add(logbook.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future addPatients(Patient patient) async {
    try {
      await _patientsCollectionReference.add(patient.toMap());
      return true;
    } catch (e) {
      return e.toString();
    }
  }

  Future getLogbookOnceOff() async {
    try {
      var logbookDocumentSnapshot =
          await _logbooksCollectionReference.getDocuments();
      if (logbookDocumentSnapshot.documents.isNotEmpty) {
        return logbookDocumentSnapshot.documents
            .map((snapshot) =>
                Logbook.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getPatientOnceOff() async {
    try {
      var patientDocumentSnapshot =
          await _patientsCollectionReference.getDocuments();
      if (patientDocumentSnapshot.documents.isNotEmpty) {
        print("-------------get once off-----------");
        return patientDocumentSnapshot.documents
            .map((snapshot) => Patient.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.patientId != null)
            .toList();
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Stream listenToLogbooksRealTime() {
    // Register the handler for when the posts data changes
    _logbooksCollectionReference.snapshots().listen((logbooksSnapshot) {
      if (logbooksSnapshot.documents.isNotEmpty) {
        var posts = logbooksSnapshot.documents
            .map((snapshot) =>
                Logbook.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.title != null)
            .toList();

        // Add the posts onto the controller
        _logbooksController.add(posts);
      }
    });

    // Return the stream underlying our _postsController.
    return _logbooksController.stream;
  }

  Stream listenToPatientsRealTime() {
    // Register the handler for when the posts data changes
    _patientsCollectionReference.snapshots().listen((patientsSnapshot) {
      if (patientsSnapshot.documents.isNotEmpty) {
        var patients = patientsSnapshot.documents
            .map((snapshot) => Patient.fromMap(snapshot.data))
            .where((mappedItem) => mappedItem.patientId != null)
            .toList();

        // Add the posts onto the controller
        _patientsController.add(patients);
      }
    });

    // Return the stream underlying our _Controller.
    return _patientsController.stream;
  }

  Future deleteLogbook(String documentId) async {
    await _logbooksCollectionReference.document(documentId).delete();
  }

  Future updateLogbook(Logbook logbook) async {
    try {
      await _logbooksCollectionReference
          .document(logbook.documentId)
          .updateData(logbook.toMap());
      return true;
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
