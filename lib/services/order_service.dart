import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_novel/models/order.dart';

class OrderService {
  final FirebaseFirestore _firestore;

  //constructor
  OrderService({FirebaseFirestore? firestore, FirebaseStorage? firebaseStorage})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> createOrder(
    String orderDate,
    String address,
    String email,
    String phoneNumber,
    String novelId,
  ) async {
    String id = '';
    await _firestore.collection('orders').add(
      {
        'order_date': orderDate,
        'address': address,
        'email': email,
        'phone_number': phoneNumber,
        'user_id': novelId,
      },
    ).then((result) {
      id = result.id;
    });
    return id;
  }

  Future<List<Order>> getOrders() async {
    QuerySnapshot querySnapshot = await _firestore.collection("orders").get();

    List<Order> result = [];
    for (var doc in querySnapshot.docs) {
      result.add(Order(
        id: doc.id,
        orderDate: doc["order_date"],
        address: doc["address"],
        userId: doc["user_id"],
      ));
    }
    return result;
  }
}
