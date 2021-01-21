import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todo_app/add/add_page.dart';
import 'package:flutter_todo_app/main_model.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TODOアプリ', home: MainPage());
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getTodoListRealTime(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('TODOアプリ'),
          ),
          body: Consumer<MainModel>(
            builder: (context, model, child) {
              final todoList = model.todoList;
              return ListView(
                children: todoList
                    .map((todo) => ListTile(
                          title: Text(todo.title),
                          subtitle: Text(todo.createdAt.toString()),
                        ))
                    .toList(),
              );
            },
          ),
          floatingActionButton:
              Consumer<MainModel>(builder: (context, model, child) {
            return FloatingActionButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddPage(model),
                      fullscreenDialog: true),
                );
              },
              child: Icon(Icons.add),
            );
          }),
        ));
  }
}
