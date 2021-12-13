import 'package:flutter/material.dart';
import './monitorSys.dart';
//import './monitorPage.dart';
import './patient.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// List<MonitorSys> monitorSys = [
//   MonitorSys(actionName: "Room Exit", status: "Active"),
//   MonitorSys(actionName: "Fall from bed", status: "Active")
// ];

String currentPatient = "Patient1";
List<Patient> patients = [
  Patient(
      patientName: "Patient1",
      patientHeight: 176,
      patientWeight: 60,
      patientAge: 80,
      patientGender: "Male",
      monitorSys: [
        MonitorSys(actionName: "Room Exit", status: "Active"),
        MonitorSys(actionName: "Fall from bed", status: "Active")
      ]),
  Patient(
      patientName: "Patient2",
      patientHeight: 169,
      patientWeight: 70,
      patientAge: 80,
      patientGender: "Female",
      monitorSys: [
        MonitorSys(actionName: "Room Exit", status: "Active"),
        MonitorSys(actionName: "Fall from bed", status: "Active")
      ]),
  Patient(
      patientName: "Patient3",
      patientHeight: 181,
      patientWeight: 60,
      patientAge: 80,
      patientGender: "Male",
      monitorSys: [
        MonitorSys(actionName: "Room Exit", status: "Active"),
        MonitorSys(actionName: "Fall from bed", status: "Active")
      ]),
];

List<MonitorSys> monitorSys = [];

void main() {
  runApp(
    MaterialApp(
      title: 'Guardian Angel routes',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the HomePage widget.
        '/': (context) => HomePage(),
        // When navigating to the "/second" route, build the Patients widget.
        '/patients': (context) => PatientsPage(),
        '/monitorSys': (context) => MonitorPage(),
      },
    ),
  );
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePageState();
  }
}

// StatelessWidget is still and not changeable to the change of data
// While Stateful can be render based on the change of data.
// adding an underline before the class name made it becomes a private class.
// by adding the underline, it shows that the thing becomes a private property.
class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/patients');
                },
                child: Text("=")),
            Text("Guardian Angel"),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
        ),
      ),
    );
  }
}

class PatientsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Patients List")),
        body: Column(
          children: patients.map((patient) {
            return Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    currentPatient = patient.patientName;
                    monitorSys = patient.monitorSys;
                    Navigator.pushNamed(context, '/monitorSys');
                  },
                  child: Text(patient.patientName),
                )
              ],
            );
          }).toList(),
        ));
  }
}

class MonitorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MonitorPageState();
  }
}

class _MonitorPageState extends State<MonitorPage> {
  // @override is a decorator provided by Dart,used to make the build override other build.
  // Widgets needs to return Widgets
  // build method is provided by the StatelessWidgets
  // when we want to change and let the pape rerender, we can use set state funciton
  // example: setState(() {
  //
  // })
  // setState run the build function when things change.
  @override
  Widget build(BuildContext context) {
    // Scaffold is another Widgets baked into material.dart
    return Scaffold(
      appBar: AppBar(
        title: Text(currentPatient),
      ),
      body: Column(
        children: monitorSys.map((ms) {
          return Row(
            children: [
              Text(ms.actionName),
              ElevatedButton(
                child: Text(ms.status),
                onPressed: (() {
                  setState(() {
                    if (ms.status == "Active") {
                      ms.status = "Inactive";
                    } else {
                      ms.status = "Active";
                    }
                  });
                }),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        }).toList(),
      ),
    );
  }
}
