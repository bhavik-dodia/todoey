class Task {
  final String name;
  final String description;
  final String time;
  bool isDone;

  Task({this.name, this.description, this.time, this.isDone = false});

  Map toJson() => {
        'name': name,
        'description': description,
        'time': time,
        'isDone': isDone
      };

  factory Task.fromJson(Map<String, dynamic> json) => Task(
      name: json['name'],
      description: json['description'],
      time: json['time'],
      isDone: json['isDone']);

  void toggleDone() {
    isDone = !isDone;
  }
}
