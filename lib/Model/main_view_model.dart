import 'package:main_project/Model/todoModel.dart';

class MainModel {
  int? total;
  int? skip;
  int? limit;
  List<TodoModel>? todos;

  MainModel({this.total, this.skip, this.limit, this.todos});

  factory MainModel.fromJson(Map<String, dynamic> json) {
    List<TodoModel> mTodos = [];
    for (Map<String, dynamic> model in json["todos"]) {
      mTodos.add(TodoModel.fromMap(model));
    }

    return MainModel(
        limit: json["limit"],
        skip: json["skip"],
        total: json["total"],
        todos: mTodos);
  }

  Map<String, dynamic> toMap() {
    return {
      "limit": limit,
      "skip": skip,
      "total": total,
      "todos": todos,
    };
  }
}
