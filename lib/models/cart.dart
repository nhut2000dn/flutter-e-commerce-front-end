// ignore: file_names
import 'package:flutter/foundation.dart';
import 'package:my_novel/models/item.dart';

class Cart extends ChangeNotifier {
  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Item item) {
    notifyListeners();
  }

  void remove(Item item) {
    notifyListeners();
  }
}
