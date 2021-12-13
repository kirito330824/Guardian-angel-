import './monitorSys.dart';

class Patient {
  final String patientName;
  int patientHeight;
  int patientWeight;
  int patientAge;
  final String patientGender;
  List<MonitorSys> monitorSys;

  Patient(
      {required this.patientName,
      required this.patientHeight,
      required this.patientWeight,
      required this.patientAge,
      required this.patientGender,
      required this.monitorSys});

  factory Patient.fromJSON(Map<String, dynamic> json) {
    return Patient(
        patientName: json["patientName"],
        patientHeight: json["patientHeight"],
        patientWeight: json["patientWeight"],
        patientAge: json["patientAge"],
        patientGender: json["patientGender"],
        monitorSys: List<MonitorSys>.from(
            json["monitorSys"].map((x) => MonitorSys.fromJSON(x))));
  }
}
