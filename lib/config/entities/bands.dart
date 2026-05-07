
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
        numberVotes: numberVotes ?? this.numberVotes,
      );
    }
}