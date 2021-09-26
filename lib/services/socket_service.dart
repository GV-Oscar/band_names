import 'package:band_names/models/band.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStatus { OnLine, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;
  List<Band> _bands = [];

  /// Obtener estado de conexion con el servidor
  ServerStatus get serverStatus => this._serverStatus;

  /// Obtener socket
  IO.Socket get socket => this._socket!;

  /// Obtener lista de bands
  List<Band> get bands => this._bands;

  SocketService() {
    this._initConfig();
  }

  _initConfig() {
    // Dart client
    this._socket = IO.io(
        'https://socket-server-bandnames.herokuapp.com/',
        IO.OptionBuilder()
            .setTransports(['websocket']) // para Flutter o Dart VM
            .enableAutoConnect() // deshabilita la conexión automática
            .build());

    this._socket!.onConnecting((data) {
      print('Connecting');
      _serverStatus = ServerStatus.Connecting;
      notifyListeners();
    });

    //socket.connect();
    this._socket!.onConnect((_) {
      print('Connect');
      _serverStatus = ServerStatus.OnLine;
      notifyListeners();
    });

    this._socket!.onDisconnect((_) {
      print('Disconnect');
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    this._socket!.onConnectTimeout((data) {
      print('onConnectTimeout : $data');
    });

    /**
    this._socket!.on('active-bands', (payload) {
      print('active-bands');
      print(payload);
      payload.forEach((element) {
        final band = new Band.fromMap(element);
        this._bands.add(band);
      });
      
      notifyListeners();
    });
     */

    /*
    this._socket!.on('mensaje', (payload) {
      print('mensaje del servidor');
      print(payload);
    });

    this._socket!.on('evento', (payload) {
      print('evento');
      print(payload);
    });
    */
  }
}
