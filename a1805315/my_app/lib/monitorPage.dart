import 'package:flutter/material.dart';
import './monitorSys.dart';

class MonitorPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MonitorPageState();
  }
}

class _MonitorPageState extends State<MonitorPage> {
  List<MonitorSys> monitorSys = [
    MonitorSys(actionName: "Room Exit", status: "Active"),
    MonitorSys(actionName: "Fall from bed", status: "Active")
  ];
  String currentPatient = "Patient1";

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
    return MaterialApp(
      home: Scaffold(
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
      ),
    );
  }
}
