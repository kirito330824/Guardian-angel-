import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/models/Logbook.dart';
import 'package:compound/services/cloud_storage_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';

class HomeViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();

  List<Logbook> _logbooks;
  List<Logbook> get Logbooks => _logbooks;

  void listenToLogbooks() {
    setBusy(true);
    _firestoreService.listenToLogbooksRealTime().listen((logbooksData) {
      List<Logbook> updatedLogbooks = logbooksData;
      if (updatedLogbooks != null && updatedLogbooks.length > 0) {
        _logbooks = updatedLogbooks;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  Future navigateToCreateView() =>
      _navigationService.navigateTo(CreateLogbookViewRoute);

  Future deleteLogbook(int index) async {
    var dialogResponse = await _dialogService.showConfirmationDialog(
      title: 'Are you sure?',
      description: 'Do you really want to delete the Logbook?',
      confirmationTitle: 'Yes',
      cancelTitle: 'No',
    );

    if (dialogResponse.confirmed) {
      var logbookToDelete = _logbooks[index];
      setBusy(true);
      await _firestoreService.deleteLogbook(logbookToDelete.documentId);
      await _cloudStorageService.deleteImage(logbookToDelete.documentId);
      setBusy(false);
    }
  }

  void editLogbook(int index) {
    _navigationService.navigateTo(CreateLogbookViewRoute,
        arguments: _logbooks[index]);
  }
}
