class TaskModel {
  String id;
  String title;
  String description;
  int date;
  bool isDone;
  String userId;

  TaskModel({
    this.id = "",
    required this.title,
    required this.description,
    required this.date,
    required this.userId,
    this.isDone = false,
  });

  TaskModel.fromJson(Map<String, dynamic> json)
      : this(
            title: json['title'],
            description: json['description'],
            date: json['date'],
            id: json['id'],
            userId: json['userId'],
            isDone: json['isDone']);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "id": id,
      "userId": userId,
      "isDone": isDone,
      "description": description,
      "date": date,
    };
  }
}
