import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_novel/models/order.dart';
import 'package:my_novel/models/order_detail.dart';

class OrderDetailService {
  final FirebaseFirestore _firestore;

  //constructor
  OrderDetailService(
      {FirebaseFirestore? firestore, FirebaseStorage? firebaseStorage})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<bool> createOrderDetail(
    double price,
    int quantily,
    String color,
    String productId,
    String orderId,
  ) async {
    bool check = false;
    await _firestore.collection('orders_details').add(
      {
        'price': price,
        'quantily': quantily,
        'color': color,
        'product_id': productId,
        'order_id': orderId,
      },
    ).then((value) => {check = true});
    return check;
  }

  Future<List<OrderDetail>> getOrders() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("orders_details").get();

    List<OrderDetail> result = [];
    for (var doc in querySnapshot.docs) {
      result.add(OrderDetail(
        id: doc.id,
        price: doc["price"],
        quantily: doc["quantily"],
        color: doc["color"],
        productId: doc["product_id"],
        orderId: doc["order_id"],
      ));
    }
    return result;
  }
}
