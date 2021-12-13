import 'package:compound/models/patient.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';
import 'package:flutter/material.dart';
import '../locator.dart';

class CreatePostViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  Future addPatient({@required String Id}) async {
    setBusy(true);
    var result = await _firestoreService.addPatients(Patient(
        patientId: Id,
        userId: currentUser.id)); // We need to add the current userId
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not add Patient',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Patient successfully Added',
        description: 'Your post has been created',
      );
    }

    _navigationService.pop();
  }
}
