import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
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
    print('addNewBand');
  }
}
