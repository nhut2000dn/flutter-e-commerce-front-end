import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_novel/models/product.dart';

class ProductService {
  final FirebaseFirestore _firestore;

  //constructor
  ProductService(
      {FirebaseFirestore? firestore, FirebaseStorage? firebaseStorage})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createProduct(
      String title,
      String images,
      String colors,
      String description,
      double price,
      int view,
      int favourite,
      int quantity,
      String brandId,
      String categoryId) async {
    await _firestore.collection('products').add(
      {
        'title': title,
        'images': images,
        'colors': colors,
        'description': description,
        'price': price,
        'view': view,
        'favourite': view,
        'quantity': quantity,
        'brand_id': brandId,
        'category_id': categoryId,
      },
    );
  }

  Future<Product> getProductById(String id) async {
    late Product product = Product(
        id: 'id',
        title: 'title',
        images: 'images',
        colors: 'colors',
        description: 'description',
        price: 100,
        view: 1,
        favourite: 1,
        quantity: 1,
        brandId: 'brand_id',
        categoryId: 'category_id');
    await _firestore.collection('products').doc(id).get().then((value) {
      product = Product(
          id: value.id,
          title: value['title'],
          images: value['images'],
          colors: value['colors'],
          description: value['description'],
          price: value['price'],
          view: value['view'],
          favourite: value['favourite'],
          quantity: value['quantity'],
          brandId: value['brand_id'],
          categoryId: value['category_id']);
    });
    return product;
  }

  Future<List<Product>> getTop5ProductView() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('products')
        .orderBy('view', descending: true)
        .limit(10)
        .get();

    List<Product> novels = [];
    for (var doc in querySnapshot.docs) {
      novels.add(Product(
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
      ));
    }
    return novels;
  }

  Future<List<Product>> getTop5NovelsFollower() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('products')
        .orderBy('favourite', descending: true)
        .limit(5)
        .get();

    List<Product> novels = [];
    for (var doc in querySnapshot.docs) {
      novels.add(Product(
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
      ));
    }
    return novels;
  }

  Future<List<Product>> search(String query) async {
    List<Product> novels = [];
    // var queryNew = query.split('');
    // int i = 0;
    // for (var element in queryNew) {
    //   queryNew[i] = element + '~';
    //   i++;
    // }
    // debugPrint(queryNew.toString());
    QuerySnapshot querySnapshot = await _firestore
        .collection('products')
        .where('title', isGreaterThanOrEqualTo: query.toUpperCase())
        .where('title', isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff')
        .get();
    for (var doc in querySnapshot.docs) {
      novels.add(Product(
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
      ));
    }
    return novels;
  }

  Future updateView(String id) async {
    await _firestore
        .collection('products')
        .doc(id)
        .update({"view": FieldValue.increment(1)});
  }

  Future<bool> updateFavouriteIncrement(String id) async {
    bool check = false;
    await _firestore.collection('products').doc(id).update(
        {"favourite": FieldValue.increment(1)}).then((value) => check = true);
    return check;
  }

  Future<bool> updateFavouriteDecrement(String id) async {
    bool check = false;
    await _firestore.collection('products').doc(id).update(
        {"favourite": FieldValue.increment(-1)}).then((value) => check = true);
    return check;
  }
}
