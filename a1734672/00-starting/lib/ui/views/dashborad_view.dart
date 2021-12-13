import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<DashboardView> {
  List<FallsData> _chartData;
  TooltipBehavior _tooltipBehavior;

  @override
  void initState() {
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Dashboard"),
            ),
            body: SfCartesianChart(
              title: ChartTitle(text: 'Patient Fall & Wandering-off History'),
              legend: Legend(isVisible: true),
              tooltipBehavior: _tooltipBehavior,
              series: <ChartSeries>[
                LineSeries<FallsData, DateTime>(
                    name: 'Falls and Wandering off',
                    dataSource: _chartData,
                    xValueMapper: (FallsData falls, _) => falls.date,
                    yValueMapper: (FallsData falls, _) => falls.times,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                    enableTooltip: true)
              ],
              primaryXAxis: DateTimeAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  visibleMinimum: DateTime.utc(2021, 10, 31),
                  visibleMaximum: DateTime.utc(2021, 11, 04),
                  intervalType: DateTimeIntervalType.days),
              primaryYAxis: NumericAxis(
                  interval: 1,
                  labelFormat: '{value} Times',
                  numberFormat: NumberFormat("#", "en_UK")),
            )));
  }

  List<FallsData> getChartData() {
    final List<FallsData> chartData = [
      FallsData(DateTime.utc(2021, 10, 31), 169),
      FallsData(DateTime.utc(2021, 11, 01), 2),
      FallsData(DateTime.utc(2021, 11, 02), 17),
      FallsData(DateTime.utc(2021, 11, 03), 0),
      FallsData(DateTime.utc(2021, 11, 04), 1),
    ];
    return chartData;
  }
}

class FallsData {
  FallsData(this.date, this.times);
  final DateTime date;
  final int times;
}
