import 'package:compound/constants/route_names.dart';
import 'package:compound/locator.dart';
import 'package:compound/models/Patient.dart';
import 'package:compound/services/cloud_storage_service.dart';
import 'package:compound/services/dialog_service.dart';
import 'package:compound/services/firestore_service.dart';
import 'package:compound/services/navigation_service.dart';
import 'package:compound/viewmodels/base_model.dart';

class PatientViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  List<Patient> _patients;
  List<Patient> get patients => _patients;

  Future fetchPatients() async {
    setBusy(true);
    // TODO: Find or Create a TaskType that will automaticall do the setBusy(true/false) when being run.
    var patientsResults = await _firestoreService.getPatientOnceOff();

    setBusy(false);

    if (patientsResults is List<Patient>) {
      _patients = patientsResults;
      notifyListeners();
    } else {
      print("--------error---------");
      await _dialogService.showDialog(
        title: 'Patients Update Failed',
        description: patientsResults,
      );
    }
  }

  Future navigateToCreateView() async {
    _navigationService.navigateTo(AddPatientViewRoute);
    await fetchPatients();
  }

  // void listenToPatients() {
  //   setBusy(true);
  //   _firestoreService.listenToPatientsRealTime().listen((PatientsData) {
  //     List<Patient> updatedPatients = PatientsData;
  //     if (updatedPatients != null && updatedPatients.length > 0) {
  //       _patients = updatedPatients;
  //       print("--------update----------");
  //       notifyListeners();
  //     }
  //     setBusy(false);
  //   });
  // }
}
