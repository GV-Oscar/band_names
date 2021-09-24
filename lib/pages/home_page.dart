import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Band> bands = [
    Band(id: '1', name: 'Mark Anthony', votes: 5),
    Band(id: '2', name: 'Daddy Yankey', votes: 4),
    Band(id: '3', name: 'Ozuna', votes: 3),
    Band(id: '4', name: 'Bad Bunny', votes: 2),
    Band(id: '5', name: 'Ricardo Arjona', votes: 7)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1.0,
        title: Text(
          'Band Names',
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
          itemCount: bands.length,
          itemBuilder: (context, i) => _bandItem(bands[i])),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          tooltip: 'Agregar nueva banda',
          elevation: 1.0,
          onPressed: addNewBand),
    );
  }

  ListTile _bandItem(Band band) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(band.name.substring(0, 2).toUpperCase()),
        backgroundColor: Colors.blue[100],
      ),
      title: Text('${band.name}'),
      trailing: Text(
        '${band.votes}',
        style: TextStyle(fontSize: 20),
      ),
      onTap: () {
        print(band.name);
      },
    );
  }

  addNewBand() {
    final txtControllerr = TextEditingController();
    if (Platform.isAndroid) {
      return showDialog(
          context: this.context,
          builder: (context) {
            return AlertDialog(
              title: Text('New band name'),
              content: TextField(
                controller: txtControllerr,
              ),
              actions: <Widget>[
                MaterialButton(
                  child: Text('Add'),
                  onPressed: () => _addBandToList(txtControllerr.text),
                  textColor: Colors.blue,
                )
              ],
            );
          });
    }

    if (Platform.isIOS) {
      return showCupertinoDialog(
          context: context,
          builder: (_) {
            return CupertinoAlertDialog(
              title: Text('New band name'),
              content: CupertinoTextField(
                controller: txtControllerr,
              ),
              actions: <Widget>[
                CupertinoDialogAction(
                  isDefaultAction: true,
                  child: Text('Add'),
                  onPressed: () => _addBandToList(txtControllerr.text),
                ),
                CupertinoDialogAction(
                  isDestructiveAction: true,
                  child: Text('Dismiss'),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            );
          });
    }
  }

  void _addBandToList(String name) {
    if (name.length > 1) {
      // podemos guardarlo
      this.bands.add(Band(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
