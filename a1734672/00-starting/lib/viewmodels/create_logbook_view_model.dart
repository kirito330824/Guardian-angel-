import 'dart:io';
import 'package:compound/locator.dart';
import 'package:compound/models/Logbook.dart';
import 'package:compound/services/cloud_storage_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/services/authentication_service.dart';
import 'package:compound/viewmodels/base_model.dart';
import 'package:compound/models/user.dart';
import 'package:flutter/material.dart';
import 'package:compound/utils/image_selector.dart';

class CreateLogbookViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  Logbook _edittingLogbook;
  bool get _editting => _edittingLogbook != null;

  File _selectedImage;
  File get selectedImage => _selectedImage;

  Future selectImage() async {
    var tempImage = await _imageSelector.selectImage();
    if (tempImage != null) {
      _selectedImage = tempImage;
      notifyListeners();
    }
  }

  Future addLogbooks({@required String title}) async {
    setBusy(true);
    var result;
    if (!_editting) {
      result = await _firestoreService
          .addLogbooks(Logbook(title: title, userId: currentUser.id));
    } else {
      result = await _firestoreService.updateLogbook(Logbook(
        title: title,
        userId: _edittingLogbook.userId,
        documentId: _edittingLogbook.documentId,
      ));
    }
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not add Logbook',
        description: result,
      );
    } else {
      await _dialogService.showDialog(
        title: 'Logbook successfully Added',
        description: 'Your Logbook has been created',
      );
    }

    _navigationService.pop();
  }

  void setEdittingLogbook(Logbook edittingLogbook) {
    _edittingLogbook = edittingLogbook;
  }
}
