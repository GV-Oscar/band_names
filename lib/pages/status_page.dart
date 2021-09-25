import 'package:band_names/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final socketService = Provider.of<SocketService>(context);
    final socket = socketService.socket;

    return Scaffold(
      body: Center(
        child: Text('ServerStatus: ${socketService.serverStatus}'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.message),
          onPressed: () {
            print('publicar mensaje');
            // Emitir mapa
            socket.emit('emitir-mensaje', {
              'mensaje': 'Hola desde Flutter',
              'nombre': 'Oscar',
              'apelido': 'Giraldo',
              'dni': '123456',
              'time': '${DateTime.now()}',
            });
          }),
    );
  }
}
