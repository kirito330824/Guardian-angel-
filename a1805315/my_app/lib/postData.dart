import 'package:flutter/material.dart';
import './monitorSys.dart';

class postData {
  String patientName;
  List<MonitorSys> monitorSys;

  postData({
    required this.patientName,
    required this.monitorSys,
  });

  factory postData.fromJSON(Map<String, dynamic> json) {
    return postData(
        patientName: json["patientName"],
        monitorSys: List<MonitorSys>.from(
            json["monitorSys"].map((x) => MonitorSys.fromJSON(x))));
  }
}
