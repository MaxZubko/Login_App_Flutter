import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:login_program/blocs/bloc_provider.dart';
import 'package:login_program/model/db_tickets.dart';

class TicketsBloc implements BlocBase {
  TicketsBloc() {
    db.init().listen((data) => _inFirestore.add(data));
  }

  String id;
  final _idController = StreamController<String>();
  Stream<String> get outId => _idController.stream;
  Sink<String> get _inId => _idController.sink;

  final _firestoreController =StreamController<QuerySnapshot>();
  Stream<QuerySnapshot> get outFirestore => _firestoreController.stream;
  Sink<QuerySnapshot> get _inFirestore => _firestoreController.sink;

  void readData() async {
    db.readData(id);
  }

  void updateData(
    DocumentSnapshot doc,
    String description,
    String image,
    String name,
    String price,
    ) {
    db.updateData(doc, description, image, name, price);
  }

  void deleteData(DocumentSnapshot doc) {
    db.deleteData(doc);
    id = null;
    _inId.add(null);
  }

  void createData(
    String description, 
    String image,
    String name,
    String price, 
  ) async {
    String id = await db.createData(description, image, name, price);
    this.id = id;
    _inId.add(this.id);
  }

  @override
  void dispose() {
    _firestoreController.close();
    _idController.close();
  }
}