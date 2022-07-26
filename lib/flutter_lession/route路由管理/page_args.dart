class PageArgs {
  final String id;
  final int action;

  PageArgs({required this.id, required this.action});

  PageArgs.from(List<Object> data)
      : this(id: data[0] as String, action: data[1] as int);

  @override
  String toString() {
    return 'PageArgs{id: $id, action: $action}';
  }
}
