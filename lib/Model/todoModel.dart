class TodoModel {
  int? id;
  String? todo;
  bool? completed;
  int? userId;

  TodoModel({this.id, this.userId, this.completed, this.todo});

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
        id: map["id"],
        completed: map["completed"],
        todo: map["todo"],
        userId: map["userId"]);
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "todo": todo,
      "completed": completed,
      "userId": userId,
    };
  }
}
