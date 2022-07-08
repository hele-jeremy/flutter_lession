library some_api;

final betty = BPlayer("betty hoko", DateTime(1992, 5, 1));
final jeam = BPlayer("jeam", DateTime(1992, 2, 3));
final kay = BPlayer("kay", DateTime(1992, 3, 2));
final maylyn = BPlayer("maylyn", DateTime(1990, 3, 2));

Group getItem() => Group(<BPlayer>{betty, jeam, kay, maylyn});

class Group {
  final Set<BPlayer> players;

  const Group(this.players);

  @override
  String toString() => players.map((e) => e.name).join(", ");
}

class BPlayer {
  final String name;
  final DateTime dayOfBirth;

  const BPlayer(this.name, this.dayOfBirth);
}
