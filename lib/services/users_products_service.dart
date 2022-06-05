import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_novel/models/product.dart';

class UsersProductsService {
  final FirebaseFirestore _firestore;

  //constructor
  UsersProductsService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> createUserProduct(String userId, String productId) async {
    String status = 'error';
    await _firestore
        .collection('users_products')
        .where('user_id', isEqualTo: userId)
        .where('product_id', isEqualTo: productId)
        .get()
        .then(
          (value) async => {
            if (value.docs.isNotEmpty)
              {
                await _firestore
                    .collection('users_products')
                    .doc(value.docs.first.id)
                    .delete()
                    .then(
                  (result) {
                    status = 'deleted';
                  },
                )
              }
            else
              {
                await _firestore.collection('users_products').add({
                  'user_id': userId,
                  'product_id': productId,
                }).then(
                  (result) {
                    status = 'created';
                  },
                )
              }
          },
        );
    return status;
  }

  Future<bool> checkIsFavourite(String userId, String productId) async {
    bool isFavourite = false;
    await _firestore
        .collection('users_products')
        .where('user_id', isEqualTo: userId)
        .where('product_id', isEqualTo: productId)
        .get()
        .then(
          (value) async => {
            if (value.docs.isNotEmpty) {isFavourite = true}
          },
        );
    return isFavourite;
  }

  Future<List<Product>?> getProducts(String userId) async {
    List<String> productIds = [];
    QuerySnapshot querySnapshot = await _firestore
        .collection("users_products")
        .where('user_id', isEqualTo: userId)
        .get();
    for (var doc in querySnapshot.docs) {
      productIds.add(doc['product_id']);
    }

    if (productIds.isNotEmpty) {
      QuerySnapshot querySnapshot2 = await _firestore
          .collection("products")
          .where(
            '__name__',
            whereIn: productIds,
          )
          .get();

      List<Product> result = [];
      for (var doc in querySnapshot2.docs) {
        result.add(
          Product(
            id: doc.id,
            title: doc['title'],
            images: doc['images'],
            colors: doc['colors'],
            description: doc['description'],
            price: doc['price'],
            view: doc['view'],
            favourite: doc['favourite'],
            quantity: doc['quantity'],
            brandId: doc['brand_id'],
            categoryId: doc['category_id'],
          ),
        );
      }
      return result;
    }
  }
}
