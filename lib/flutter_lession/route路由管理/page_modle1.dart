class PageModel1 {
  final String id;
  final int count;
  final double price;

  PageModel1({required this.id, required this.count, required this.price});

  PageModel1.from(Map<String, Object> data)
      : this(
            id: data["id"] as String,
            count: data["count"] as int,
            price: data["price"] as double);

  @override
  String toString() {
    return 'PageModel1{id: $id, count: $count, price: $price}';
  }
}
