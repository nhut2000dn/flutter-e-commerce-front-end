class RouteArgument {
  String? id;
  int? index;
  int? lenght;
  List<dynamic>? argumentsList;

  RouteArgument({
    this.id,
    this.index,
    this.lenght,
    this.argumentsList,
  });

  @override
  String toString() {
    return '{id: $id, heroTag:${argumentsList.toString()}}';
  }
}
