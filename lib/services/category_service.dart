import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_novel/models/category.dart';

class CategoryService {
  final FirebaseFirestore _firestore;

  //constructor
  CategoryService(
      {FirebaseFirestore? firestore, FirebaseStorage? firebaseStorage})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> createCategory(
    String name,
    String image,
    String description,
  ) async {
    await _firestore.collection('categories').add(
      {
        'name': name,
        'image': image,
        'description': description,
      },
    );
  }

  Future<List<Category>> getCategoryss() async {
    QuerySnapshot querySnapshot =
        await _firestore.collection("categories").get();

    List<Category> result = [];
    for (var doc in querySnapshot.docs) {
      result.add(Category(
          id: doc.id,
          name: doc["name"],
          image: doc["image"],
          description: doc["description"]));
    }
    return result;
  }

  // Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getCategorys() async {
  //   final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
  //       _firestore.collection("Categorys").snapshots();
  //   return snapshots;

  //   // DocumentSnapshot<Map<String, dynamic>> userData =
  //   //     await _firestore.collection('users').doc('PpBlD7y5CYVRGKqfTpND').get();
  //   // debugPrint(userData.data()!['fullName']);
  //   // Query<Map<String, dynamic>> query = _firestore.collection("Categorys");
  //   // final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
  //   //     query.snapshots();

  //   // List<Map<String, String>> CategoryList = [];
  //   // Query<Map<String, dynamic>> query = _firestore.collection("Categorys");
  //   // final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots =
  //   //     query.snapshots();
  //   // snapshots.forEach((element) {
  //   //   for (var element in element.docs) {
  //   //     Map<String, String> Category = {};
  //   //     Category['id'] = element.id;
  //   //     Category['name'] = element.data()['name'];
  //   //     Category['image'] = element.data()['image'];
  //   //     Category['description'] = element.data()['description'];
  //   //     CategoryList.add(Category);
  //   //   }
  //   // });
  //   // debugPrint('sss');
  //   // CategoryList.forEach((element) {
  //   //   debugPrint('sss');
  //   // });

  //   // return CategoryList;
  // }
}
