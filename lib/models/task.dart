class Task {
  final String name;
  bool isDone;

  Task({this.name, this.isDone = false});

  Map toJson() => {'name': name, 'isDone': isDone};

  factory Task.fromJson(Map<String, dynamic> json) => Task(name: json['name'] as String, isDone: json['isDone'] as bool);

  void toggleDone() {
    isDone = !isDone;
  }
}
