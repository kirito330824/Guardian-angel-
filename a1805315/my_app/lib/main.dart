import 'package:flutter/material.dart';
import './monitorSys.dart';
//import './monitorPage.dart';
import './patient.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import './postData.dart';

// List<MonitorSys> monitorSys = [
//   MonitorSys(actionName: "Room Exit", status: "Active"),
//   MonitorSys(actionName: "Fall from bed", status: "Active")
// ];

Future<List<Patient>> _fetchPatients() async {
  final response = await http.get(Uri.parse('http://10.0.2.2:5000/getdata'));
  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    List<Patient> patients =
        List<Patient>.from(json['patients'].map((x) => Patient.fromJSON(x)));
    print(patients[0].patientAge);
    return patients;
  } else {
    throw Exception("Error getting patient data");
  }
}

String currentPatient = "Patient1";
List<MonitorSys> monitorSys = [];

void main() async {
  // Future<List<Patient>> _data = _fetchPatients();
  // List <Patient> patients = await _data;
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
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = _fetchPatients();
  }

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

class PatientsPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PatientsState();
  }
}

class _PatientsState extends State<PatientsPage> {
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = _fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Patients List")),
        body: FutureBuilder(
            future: futurePatients,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var patients = snapshot.data as List<Patient>;
                return Column(
                  children: patients.map((patient) {
                    return Row(children: [
                      ElevatedButton(
                        onPressed: () {
                          currentPatient = patient.patientName;
                          monitorSys = patient.monitorSys;
                          Navigator.pushNamed(context, '/monitorSys');
                        },
                        child: Text(patient.patientName),
                      )
                    ]);
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }));
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
  late Future<List<Patient>> futurePatients;
  // @override is a decorator provided by Dart,used to make the build override other build.
  // Widgets needs to return Widgets
  // build method is provided by the StatelessWidgets
  // when we want to change and let the pape rerender, we can use set state funciton
  // example: setState(() {
  //
  // })
  // setState run the build function when things change.
  @override
  void initState() {
    super.initState();
    futurePatients = _fetchPatients();
  }

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
