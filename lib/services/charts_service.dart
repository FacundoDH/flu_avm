// ignore: unused_import
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChartService {

  IO.Socket? _socket;

  void connect() {
    _socket = IO.io('http://localhost:3200',
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build()
    );

    _socket!.onConnect((_) {
      _socket!.on('CLIENT_JOINED', (payload) {
        //TODO Al usuario que haya llegado lo meteré en el almacen para verlo en pantalla

      });

      _socket!.on('CLIENT_LEFT', (payload) {
        //TODO Borraré ese usuario del almacén y desaparecerá de la pantalla
      
      });

      _socket!.on('CLIENT_MOVED', (payload) {
        //TODO Cambiaré la posición del usuario
      });

      _socket!.on('GET_CLIENTS', (payload) {
        //TODO Lista de clientes conectados
      });
    });

    _socket!.connect();
  }

  void finish() {
    _socket!.disconnect();
    _socket?.dispose();
    _socket = null;
  }
}

