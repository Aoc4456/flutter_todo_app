import 'package:flutter/material.dart';
import 'package:flutter_todo_app/main_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getTodoList(),
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
                        ))
                    .toList(),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}
