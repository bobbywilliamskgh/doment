import 'package:cloud_firestore/cloud_firestore.dart';

class DBHelper {
  static Future<QuerySnapshot> getDataFromCollections(
      {String colRef1,
      String colRef2,
      String doc,
      bool filtering = false,
      String filteringField}) {
    final firestore = FirebaseFirestore.instance;
    if (colRef2 == null) {
      return firestore.collection(colRef1).get();
    } else {
      if (filtering) {
        return firestore
            .collection(colRef1)
            .doc(doc)
            .collection(colRef2)
            .orderBy(filteringField, descending: true)
            .get();
      }
      print('getData prescriptions');
      return firestore.collection(colRef1).doc(doc).collection(colRef2).get();
    }
  }

  static Future<DocumentSnapshot> getDataFromSpesificDoc(
      {String colRef1,
      String colRef2,
      String doc1,
      String doc2,
      bool filtering = false}) {
    final firestore = FirebaseFirestore.instance;
    if (colRef2 == null) {
      return firestore.collection(colRef1).doc(doc1).get();
    } else {
      return firestore
          .collection(colRef1)
          .doc(doc1)
          .collection(colRef2)
          .doc(doc2)
          .get();
    }
  }

  static Future<void> setData(
      {String colRef1,
      String colRef2,
      Map<String, dynamic> data,
      String id1,
      String id2}) {
    final firestore = FirebaseFirestore.instance;
    if (colRef2 == null) {
      return firestore.collection(colRef1).doc(id1).set(data);
    } else {
      return firestore
          .collection(colRef1)
          .doc(id1)
          .collection(colRef2)
          .doc(id2)
          .set(data);
    }
  }

  static Future<DocumentReference> addData({
    String colRef1,
    String colRef2,
    Map<String, dynamic> data,
    String id,
  }) {
    final firestore = FirebaseFirestore.instance;
    if (colRef2 == null) {
      return firestore.collection(colRef1).add(data);
    } else {
      if (id == null) {
        return firestore
            .collection(colRef1)
            .doc()
            .collection(colRef2)
            .add(data);
      } else {
        return firestore
            .collection(colRef1)
            .doc(id)
            .collection(colRef2)
            .add(data);
      }
    }
  }
}
