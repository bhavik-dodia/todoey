import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:Todoey/models/task.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

class TaskData extends ChangeNotifier {
  bool _deleteOnComplete = false;

  bool get deleteOnComplete => _deleteOnComplete;

  set deleteOnComplete(bool value) {
    _deleteOnComplete = value;
    notifyListeners();
  }

  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void loadTasks(String res) {
    var taskObj = jsonDecode(res) as List;
    _tasks = taskObj.map((i) => Task.fromJson(i)).toList();
    notifyListeners();
  }

  void saveTasks() {
    getApplicationDocumentsDirectory().then((Directory directory) {
      File('${directory.path}/tasks.json')
          .writeAsStringSync(jsonEncode(_tasks));
    });
  }

  void addTask(String newTaskTitle, String newDescription, String time) {
    _tasks
        .add(Task(name: newTaskTitle, description: newDescription, time: time));
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    if (_deleteOnComplete) deleteTask(task);
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
