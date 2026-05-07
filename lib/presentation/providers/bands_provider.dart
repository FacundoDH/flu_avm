import 'package:flu_avm/config/config.dart';
import 'package:flutter_riverpod/legacy.dart';

final bandsProvider = StateNotifierProvider<BandsNotifier, List<Band>>((ref){
  return BandsNotifier();
});

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