// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors

import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/Todo_model.dart';

class HomePage extends StatelessWidget {
  final String title;
  HomePage({Key? key, required this.title}) : super(key: key);

  List<TodoModel> todoList = [];
  Future<List<TodoModel>> getTodoList() async {
    var url = "https://jsonplaceholder.typicode.com/todos";
    final response = await http.get(Uri.parse(url));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        // adding way 1
        TodoModel todoModel = TodoModel(
            userId: i['userId'],
            id: i["id"],
            title: i["title"],
            completed: i["completed"]);
        todoList.add(todoModel);

        // adding way 2
        // todoList.add(TodoModel.fromJson(i));
      }
      return todoList;
    }
    return todoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(title)),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getTodoList(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                        child: const CircularProgressIndicator(
                      strokeWidth: 2.0,
                    ));
                  } else {
                    return ListView.builder(
                        itemCount: todoList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                                margin: EdgeInsets.all(5),
                                elevation: 3,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ListTile(
                                        title: Text(
                                            todoList[index].title.toString()),
                                        subtitle: Text(todoList[index]
                                            .completed
                                            .toString()),
                                      ),
                                    ],
                                  ),
                                )),
                          );
                        });
                  }
                }),
          )
        ],
      ),
    );
  }
}
