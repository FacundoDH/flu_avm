
class Band {
  String id;
  String name;
  int numberVotes;

  Band({
    required this.id,
    required this.name,
    required this.numberVotes
  });
}

List<Band> bands = [
  Band(id: '1', name: 'Metallica', numberVotes: 5),
  Band(id: '2', name: 'Queen', numberVotes: 1),
  Band(id: '3', name: 'Strokes', numberVotes: 2),
  Band(id: '4', name: 'LowRoar', numberVotes: 6),
];