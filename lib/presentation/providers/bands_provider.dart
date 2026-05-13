import 'package:flu_avm/config/config.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: constant_identifier_names
enum ServerStatus { Online, Offline, Connecting }

final bandsProvider = StateNotifierProvider<BandsNotifier, BandsState>((ref){
  return BandsNotifier();
});


class BandsState {
  final ServerStatus serverStatus;
  final IO.Socket socket;
  final List<Band> bands;

  BandsState({
    required this.serverStatus,
    required this.socket,
    required this.bands
  });

  BandsState copyWith({
    ServerStatus? serverStatus,
    IO.Socket? socket,
    List<Band>? bands
  }) => BandsState(
    serverStatus: serverStatus ?? this.serverStatus,
    socket: socket ?? this.socket,
    bands: bands ?? this.bands,
  );
}

class BandsNotifier extends StateNotifier<BandsState>{
  BandsNotifier()
   : super(BandsState(
    serverStatus: ServerStatus.Connecting,
    socket: IO.io(
      'http://localhost:3000', //si no funciona poner la ip
      IO.OptionBuilder()
        .setTransports(['websocket'])
        .enableAutoConnect()
        .build()
    ),
    bands: []
  )) {

    _initConfig();

  }

  void _initConfig() {

    state.socket.onConnect(( _ ) {
      state = state.copyWith(serverStatus: ServerStatus.Online);
    });

    state.socket.onDisconnect(( _ ) {
      state = state.copyWith(serverStatus: ServerStatus.Offline);
    });

    state.socket.on('BANDS_LIST', (payload) {
      final bands = (payload as List).map((band) => Band.fromMap(band)).toList();
      state = state.copyWith(bands: bands);
    });
  }

  void addBand(String name) {
    if (name.length > 1) {
      state.socket.emit('ADD_BAND', {'name': name});
    }
  }

  void addVote(String id) {
    state.socket.emit('VOTE_BAND', {'id': id});
  }

  void deleteBand(String id) {
    state.socket.emit('DELETE_BAND', {'id': id});
  }
}







/*

class BandsNotifier extends StateNotifier<List<Band>>{

  BandsNotifier() : super([
    Band(id: '1', name: 'Metallica', numberVotes: 5),
    Band(id: '2', name: 'Queen', numberVotes: 1),
    Band(id: '3', name: 'Strokes', numberVotes: 2),
    Band(id: '4', name: 'LowRoar', numberVotes: 6),
  ]); //creamos un constructor, la instancia que se cree se inicializa por la clase padre

  void addBand(Band band) {
    state = [ ... state, band];
  }

  void deleteBand(Band band) {
    state = state.where((b) => b.id != band.id).toList();
  }

  void addVote(Band band) {
    state = state.map((b) {
      return  b.id == band.id
      ? b.copyWith(numberVotes: b.numberVotes + 1)
      : b;
    }).toList();
  }

}

*/