import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:security_camera_app/models/camera.dart';
import 'package:security_camera_app/view/shared_widgets/input_field.dart';

class Popup extends StatefulWidget {
  final String qrValueText;

  const Popup({Key key, this.qrValueText}) : super(key: key);

  @override
  _PopupState createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  TextEditingController name = new TextEditingController();
  TextEditingController login = new TextEditingController();
  TextEditingController password = new TextEditingController();
  TextEditingController qrValue = new TextEditingController();
  @override
  void initState() {
    qrValue.text = widget.qrValueText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final camerasBox = Hive.box('Cameras');


    return AlertDialog(
        content: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 4),
                Text(
                  'Enter camera info',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: InputField(
                    helperText: 'camera nickname',
                    controller: name,
                    minLength: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: InputField(
                    helperText: 'login',
                    controller: login,
                    minLength: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: InputField(
                    helperText: 'password',
                    controller: password,
                    minLength: 5,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(3.0),
                  child: InputField(
                    helperText: 'serial number',
                    controller: qrValue,
                    minLength: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RaisedButton(
                  color: Colors.white,
                  child: Text(
                    'DISCARD',
                    style: TextStyle(
                      color: Color(0xFF002c55),
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    name.text = '';
                    login.text = '';
                    password.text = '';
                    Navigator.pop(context);
                  },
                ),
                RaisedButton(
                  color: Color(0xFF002c55),
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  onPressed: () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      camerasBox.put(
                        qrValue.text,
                        CameraModel(
                          name: name.text,
                          description: 'description',
                          login: login.text,
                          password: password.text,
                          qrValue: qrValue.text,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
      ],
    ),
        ));
  }
}
