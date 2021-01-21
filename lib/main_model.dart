import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MainModel extends ChangeNotifier {
  List<Todo> todoList = [];

  Future getTodoList() async {
    // FirebaseFireStore.instance.collection('~~').get()  でクエリのドキュメントを取得
    final snapshot =
        await FirebaseFirestore.instance.collection('todoList').get();
    final docs = snapshot.docs;
    this.todoList = docs.map((doc) => Todo(doc)).toList();
    notifyListeners();
  }

  void getTodoListRealTime() {
    // FirebaseFireStore.instance.collection('~~').snapshots()  でStreamを取得
    final snapshots =
        FirebaseFirestore.instance.collection('todoList').snapshots();
    snapshots.listen((snapshot) {
      final docs = snapshot.docs;
      final todoList = docs.map((doc) => Todo(doc)).toList();
      todoList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      this.todoList = todoList;
      notifyListeners();
    });
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
