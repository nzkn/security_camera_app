import 'package:flutter/material.dart';

class InputField extends StatefulWidget {

  final String helperText;
  final TextEditingController controller;
  final int minLength;

  const InputField({this.helperText, this.controller, this.minLength});

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        top: 8,
      ),
      width: screenWidth,
      child: TextFormField(
        controller: widget.controller,
        obscureText: false,
        validator: (val) =>
        val.length < widget.minLength ? 'This field can\'t contain less than ${widget.minLength} symbols' : null,
        decoration: textInputDecoration.copyWith(
          helperText: widget.helperText,
        ),
        cursorRadius: Radius.circular(0),
      ),
    );
  }
}

const textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(
    vertical: 3,
    horizontal: 15,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(119, 119, 119, 1),
      width: 1,
    ),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Color.fromRGBO(119, 119, 119, 1),
      width: 1,
    ),
  ),
);