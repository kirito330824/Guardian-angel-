class MonitorSys {
  final String actionName;
  String status;

  MonitorSys({this.actionName, this.status});

  factory MonitorSys.fromJSON(Map<String, dynamic> json) {
    return MonitorSys(actionName: json["actionName"], status: json["status"]);
  }
}
