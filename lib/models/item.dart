import 'package:meta/meta.dart';
import 'package:my_novel/models/product.dart';

@immutable
class Item {
  final dynamic id;
  final dynamic name;
  final String color;
  final double price;
  final int quantity;
  final Product object;

  // ignore: prefer_const_constructors_in_immutables
  Item(this.id, this.name, this.color, this.price, this.quantity, this.object);

  @override
  bool operator ==(Object other) => other is Item && other.id == id;
}
