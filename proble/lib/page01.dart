import 'dart:io';
import 'dart:async';

import 'package:path_provider/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Home extends StatefulWidget {
  final Storage storage;

  Home({Key key, @required this.storage}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  TextEditingController controller = TextEditingController();
  TextEditingController controllero = TextEditingController();
  String state;
  String statetwo;
  Future<Directory> _appDocDir;

  @override
  void initState() {
    super.initState();
    widget.storage.readData().then((String value) {
      setState(() {
        state = value;
      });
    });
    widget.storage.readDataone().then((String value) {
      setState(() {
        statetwo = value;
      });
    });
  }

  Future<File> writeData() async {
    setState(() {
      state = controller.text;
      controller.text = '';
    });

    return widget.storage.writeData(state);
  }

  Future<File> writeDataa() async {
    setState(() {
      statetwo = controllero.text;
      controllero.text = '';
    });

    return widget.storage.writeData(statetwo);
  }

  void getAppDirectory() {
    setState(() {
      _appDocDir = getApplicationDocumentsDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reading and Writing Files'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('${state ?? "File is Empty"}'),
            Text('${statetwo ?? "File is Empty"}'),
            TextField(
              controller: controller,
            ),
            TextField(
              controller: controllero,
            ),
            RaisedButton(
              onPressed: () {
                writeData();
                writeDataa();
              },
              child: Text('Write to File'),
            ),
            RaisedButton(
              child: Text("Get DIR path"),
              onPressed: getAppDirectory,
            ),
            FutureBuilder<Directory>(
              future: _appDocDir,
              builder:
                  (BuildContext context, AsyncSnapshot<Directory> snapshot) {
                Text text = Text('');
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    text = Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    text = Text('Path: ${snapshot.data.path}');
                  } else {
                    text = Text('Unavailable');
                  }
                }
                return new Container(
                  child: text,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class Storage {
  Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get localFile async {
    final path = await localPath;
    return File('$path/db.txt');
  }

  Future<File> get localFileone async {
    final path = await localPath;
    return File('$path/json.txt');
  }

  Future<String> readData() async {
    try {
      final file = await localFileone;
      String contents = await file.readAsString();

      return contents;
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> readDataone() async {
    try {
      final file = await localFile;
      String body = await file.readAsString();

      return body;
    } catch (e) {
      return e.toString();
    }
  }

  Future<File> writeData(String data) async {
    final file = await localFile;
    return file.writeAsString('$data');
  }

  Future<File> writeDataone(String dataone) async {
    final file = await localFileone;
    return file.writeAsString('$dataone');
  }
}
