import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MySpeechDial extends StatelessWidget {
  final Function qrFunction;
  final Function manualFunction;

  const MySpeechDial({Key key, this.qrFunction, this.manualFunction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      marginRight: 15,
      marginBottom: 25,
      closeManually: false,
      overlayColor: Colors.white,
      overlayOpacity: 0.5,
      backgroundColor: Color(0xFF002c55),
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      animatedIcon: AnimatedIcons.menu_close,
      animatedIconTheme: IconThemeData(size: 22.0),
      children: [
        SpeedDialChild(
            child: Icon(Icons.qr_code),
            backgroundColor: Color(0xFF002c55),
            label: 'Scan QR code',
            labelStyle: TextStyle(fontSize: 15.0),
            onTap: qrFunction,
        ),
        SpeedDialChild(
          child: Icon(Icons.edit),
          backgroundColor: Color(0xFF002c55),
          label: 'Enter manually',
          labelStyle: TextStyle(fontSize: 15.0),
          onTap: manualFunction,
        ),
      ],
    );
  }
}
