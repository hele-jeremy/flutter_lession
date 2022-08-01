extension IntExtension on int {
  void times(void Function(int) f) {
    for (int i = 0; i < this; i++) {
      // Function.apply(f, toListWithValue(i));
      //  f.call(i);
      f(i);
    }
  }

  List<E> reduceTimes<E>(E Function(int) f) {
    return [for (int i = 0; i < this; i++) f(i)];
  }

  List<int> toList() => [this];

  List<int> toListWithValue(int value) => [value];
}

extension NumberParsing on String {
  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

  String scream() => toUpperCase();
}

extension MapExtension<K, V> on Map<K, V> {

  List<R> transformMap<R>(R Function(MapEntry<K, V> entry) transformer) {
    return [for (final kvEntry in entries) transformer(kvEntry)];
  }
}
