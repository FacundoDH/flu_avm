
class Band {
  String id;
  String name;
  int numberVotes;

  Band({
    required this.id,
    required this.name,
    required this.numberVotes
  });

  Band copyWith({
    String? id,
    String? name,
    int? numberVotes
    }) {
      return Band(
        id: id ?? this.id,
        name: name ?? this.name,
        numberVotes: numberVotes ?? this.numberVotes
    );
  }

  factory Band.from(Map<String, dynamic> obj) {
    return Band(
      id: obj['id'],
      name: obj['name'],
      numberVotes: obj['numberVotes']
    );
  }

}