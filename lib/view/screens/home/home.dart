import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:security_camera_app/models/camera.dart';
import 'package:security_camera_app/view/screens/home/widgets/popup.dart';
import 'package:security_camera_app/view/screens/home/widgets/speed_dial.dart';
import 'package:security_camera_app/view/screens/live_camera/live_camera.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final camerasBox = Hive.box('cameras');
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color(0xFF002c55),
        title: Text('My cameras'),
      ),
      body: ValueListenableBuilder(
        valueListenable: camerasBox.listenable(),
        builder: (context, Box<dynamic> camerasBox, _) {
          return ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            itemCount: camerasBox.length,
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 5,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              CameraModel cameraModel = camerasBox.getAt(index);
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          LiveCamera(cameraModel: cameraModel),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Camera #${index + 1}',
                              style: TextStyle(
                                fontSize: 12.5,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              cameraModel.name,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              cameraModel.qrValue,
                              style: TextStyle(
                                fontSize: 12.5,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            print('Delete: ${cameraModel.qrValue}');
                            camerasBox.delete(cameraModel.qrValue);
                          },
                          child: Icon(
                            Icons.clear,
                            color: Color(0xFF002c55),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: MySpeechDial(
        qrFunction: () async {
          var scanResult = await BarcodeScanner.scan();
          print('${scanResult.rawContent}');
          if (scanResult.rawContent.length >= 13) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Popup(qrValueText: scanResult.rawContent);
              },
            );
          }
        },
        manualFunction: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Popup();
            },
          );
        },
      ),
    );
  }
}
