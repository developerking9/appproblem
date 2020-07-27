import 'package:flutter/material.dart';

class data extends StatefulWidget {
  @override
  _dataState createState() => _dataState();
}

class _dataState extends State<data> {
  String omsairam = 'jai shri ram';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Material(
          child: Text(
              "FIRST button  will save the value\n and second button will navigate it"),
        ),
        SizedBox(
          width: 30,
        ),
        Container(
          child: RaisedButton(onPressed: () {
            omsai(
              hanuman: omsairam,
            );
          }),
        ),
        Container(
          child: RaisedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => omsai()),
            );
          }),
        ),
      ]),
    );
  }
}

class omsai extends StatefulWidget {
  final String hanuman;

  const omsai({Key key, this.hanuman}) : super(key: key);
  @override
  _omsaiState createState() => _omsaiState();
}

class _omsaiState extends State<omsai> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      child: Material(child: Text(widget.hanuman)),
    ));
  }
}
