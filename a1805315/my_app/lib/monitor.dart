import 'package:flutter/material.dart';

class MonitorButton extends StatelessWidget {
  final Function handleClick;
  final String monitorText;

  MonitorButton(this.handleClick, this.monitorText);
  @override
  Widget build(BuildContext context) {
    return Container(
        child: ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
      ),
      child: Text(monitorText),
      onPressed: handleClick(),
    ));
  }
}
