import 'package:cloud_firestore/cloud_firestore.dart';

class DB_tickets {
  final db = Firestore.instance;

  Stream<QuerySnapshot> init() {
    return db.collection('tickets').snapshots();
  }

  Future<String> createData(
    String description,
    String image,
    String name,
    String price,
  ) async {
    DocumentReference ref = await db.collection('tickets').add({
      // 'description': '$description',
      // 'image': '$image',
      // 'name': '$name',
      // 'price': '$price',
      'description': 'description',
      'image': 'image',
      'name': 'name',
      'price': 'price',
    });
    print(ref.documentID);
    return ref.documentID;
  }

  void readData(String id) async {
    DocumentSnapshot snaphot =
        await db.collection('tickets').document(id).get();
    print(snaphot.data['description']);
    print(snaphot.data['image']);
    print(snaphot.data['name']);
    print(snaphot.data['price']);
  }

  void updateData(
    DocumentSnapshot doc,
    String description,
    String image,
    String name,
    String price,
  ) async {
    await db.collection('tickets').document(doc.documentID).updateData({
      'description': '$description',
      'image': 'image',
      'name': '$name',
      'price': '$price',
    });
  }

  void deleteData(DocumentSnapshot doc) async {
    await db.collection('tickets').document(doc.documentID).delete();
  }
}

DB_tickets db = DB_tickets();
