// ignore: unused_import
import 'dart:async';
import 'package:flu_avm/config/config.dart';
//import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// Contrato Socket.IO con el backend:
// - Cliente emite 'CLIENT_REGISTER': { nomen, color (hex), lng, lat }
// - Cliente emite 'CLIENT_MOVE': { lng, lat }
// - Servidor emite 'CLIENT_JOINED': { id, nomen, color, lng, lat }
// - Servidor emite 'CLIENT_LEFT': { id }
// - Servidor emite 'CLIENT_MOVED': { id, lng, lat }
// - Servidor emite 'GET_CLIENTS': [ { id, nomen, color, lng, lat }, ... ]

class ChartService {

  IO.Socket? _socket;

  final Map<String, User> _users = {};

  late final StreamController<List<User>> _usersController;

  Stream<List<User>> get usersStream => _usersController.stream;

  String? get mySocketId => _socket?.id;

  ChartService() {
    _usersController = StreamController<List<User>>.broadcast();
  }

  void connect() {
    _socket = IO.io('http://10.0.2.2:3200',
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build()
    );

    _socket!.onConnect((_) {
      _socket!.on('CLIENT_JOINED', (payload) {
        
        final user = User.fromJson(Map<String, dynamic>.from(payload));

        _users[user.id] = user;

        _usersListRevew();
      });

      _socket!.on('CLIENT_LEFT', (payload) {
        
        final id = payload['id'] as String;

        _users.remove(id);

        _usersListRevew();
      
      });

      _socket!.on('CLIENT_MOVED', (payload) {
        
        final map = Map<String, dynamic>.from(payload);

        final id = map['id'] as String;

        final lng = map['lng'] as double;

        final lat = map['lat'] as double;

        _users[id] = _users[id]!.copyWith(position: Position(lng,lat));

        _usersListRevew();

      });

      _socket!.on('GET_CLIENTS', (payload) {
        
        _users.clear();

        for (final item in payload) {
          final user = User.fromJson(item);
          _users[user.id] = user;
        }

        _usersListRevew();

      });
    });

    _socket!.connect();
  }

  void _usersListRevew() {
    _usersController.add(List.from(_users.values));
  }

  void emitUser({
    required String name,
    required String colorHex,
    required Position position,
  }) {
    _socket!.emit('CLIENT_REGISTER', {
      'name': name,
      'color': colorHex,
      'lng': position.lng,
      'lat': position.lat
    });
  }

  void emitPosition(Position position) {
    _socket!.emit('CLIENT_MOVE', {
      'lng': position.lng,
      'lat': position.lat,
    });
  }

  void finish() {
    _socket!.disconnect();
    _socket?.dispose();
    _socket = null;
    _users.clear();
    _usersController.add([]);
    _usersController.close();
  }
}

