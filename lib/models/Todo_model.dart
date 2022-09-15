class TodoModel {
  TodoModel({
      required this.userId,
      required this.id,
      required this.title,
      required this.completed,
  });

  TodoModel.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    completed = json['completed'];
  }
  int userId = 1;
  int id = 1;
  String title = '';
  bool completed = false;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = userId;
    map['id'] = id;
    map['title'] = title;
    map['completed'] = completed;
    return map;
  }

}