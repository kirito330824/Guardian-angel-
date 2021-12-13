import 'package:flutter/material.dart';
import 'package:my_app/backup.dart';
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

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Patient>> futurePatients;

  @override
  void initState() {
    super.initState();
    futurePatients = _fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder(
            future: futurePatients,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var patients = snapshot.data as List<Patient>;
                // Text(((snapshot.data as List<Patient>)[0].patientName))
                return Column(
                  children: patients.map((patient) {
                    return Text(patient.patientName);
                  }).toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
