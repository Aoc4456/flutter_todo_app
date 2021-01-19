import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  List<Todo> todoList = [];

  Future getTodoList() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('todoList').get();
    final docs = snapshot.docs;
    this.todoList = docs.map((doc) => Todo(doc)).toList();
    notifyListeners();
  }
}

class Todo {
  Todo(DocumentSnapshot doc) {
    this.title = doc.data()['title'];

    final timeStamp = doc.data()['createdAt'];
    this.createdAt = (timeStamp as Timestamp).toDate();
  }

  String title;
  DateTime createdAt;
}
