// import 'package:flutter/material.dart';
// import './monitorSys.dart';
// //import './monitorPage.dart';
// // import './patient.dart';
// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';
// import './patient.dart';
// // import './postData.dart';

// // class HomeView extends StatelessWidget {
// //   const HomeView({Key key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Center(
// //       child: Text('Guardian Angel Home'),
// //     );
// //   }
// // }

// String currentPatient = "Patient1";
// List<Patient> patients = [
//   Patient(
//       patientName: "Patient1",
//       patientHeight: 176,
//       patientWeight: 60,
//       patientAge: 80,
//       patientGender: "Male",
//       monitorSys: [
//         MonitorSys(actionName: "Room Exit", status: "Active"),
//         MonitorSys(actionName: "Fall from bed", status: "Active")
//       ]),
//   Patient(
//       patientName: "Patient2",
//       patientHeight: 169,
//       patientWeight: 70,
//       patientAge: 80,
//       patientGender: "Female",
//       monitorSys: [
//         MonitorSys(actionName: "Room Exit", status: "Active"),
//         MonitorSys(actionName: "Fall from bed", status: "Active")
//       ]),
//   Patient(
//       patientName: "Patient3",
//       patientHeight: 181,
//       patientWeight: 60,
//       patientAge: 80,
//       patientGender: "Male",
//       monitorSys: [
//         MonitorSys(actionName: "Room Exit", status: "Active"),
//         MonitorSys(actionName: "Fall from bed", status: "Active")
//       ]),
// ];

// List<MonitorSys> monitorSys = [];

// class HomeView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     return _HomeViewState();
//   }
// }

// class _HomeViewState extends State<HomeView> {
//   Future<List<Patient>> futurePatients;

//   @override
//   void initState() {
//     super.initState();
//     // futurePatients = _fetchPatients();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Row(
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/patients');
//                 },
//                 child: Text("=")),
//             Text("Guardian Angel"),
//           ],
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         ),
//       ),
//     );
//   }
// }

// class PatientsPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _PatientsState();
//   }
// }

// class _PatientsState extends State<PatientsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Patients List")),
//         body: Column(
//           children: patients.map((patient) {
//             return Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     currentPatient = patient.patientName;
//                     monitorSys = patient.monitorSys;
//                     Navigator.pushNamed(context, '/monitorSys');
//                   },
//                   child: Text(patient.patientName),
//                 )
//               ],
//             );
//           }).toList(),
//         ));
//   }
// }
