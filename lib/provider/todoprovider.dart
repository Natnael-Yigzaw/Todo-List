import 'package:flutter/material.dart';
import 'package:my_todo/model/task.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TodoProvider extends ChangeNotifier {
  List<Task> _tasks = [];
  final List<Task> _favoriteTasks = [];
  SharedPreferences? _prefs;

  List<Task> get tasks => _tasks;
  List<Task> get favoriteTasks => _favoriteTasks;

  TodoProvider() {
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    _prefs = await SharedPreferences.getInstance();
    final tasksJson = _prefs!.getString('tasks');
    final favoriteTasksJson = _prefs!.getString('favoriteTasks');

    if (tasksJson != null) {
      final List<dynamic> decodedTasks = jsonDecode(tasksJson);
      _tasks.clear();
      for (var decodedTask in decodedTasks) {
        _tasks.add(Task.fromJson(decodedTask));
      }
    }

    if (favoriteTasksJson != null) {
      final List<dynamic> decodedFavoriteTasks = jsonDecode(favoriteTasksJson);
      _favoriteTasks.clear();
      for (var decodedTask in decodedFavoriteTasks) {
        _favoriteTasks.add(Task.fromJson(decodedTask));
      }
    }

    notifyListeners();
  }

  Future<void> _saveTasks() async {
    final List<Map<String, dynamic>> encodedTasks =
        _tasks.map((task) => task.toJson()).toList();
    final tasksJson = jsonEncode(encodedTasks);
    await _prefs!.setString('tasks', tasksJson);
  }

  Future<void> _saveFavoriteTasks() async {
    final List<Map<String, dynamic>> encodedFavoriteTasks =
        _favoriteTasks.map((task) => task.toJson()).toList();
    final favoriteTasksJson = jsonEncode(encodedFavoriteTasks);
    await _prefs!.setString('favoriteTasks', favoriteTasksJson);
  }

  void addTask(Task task) {
    if (!_tasks.contains(task)) {
      _tasks.add(task);
      _saveTasks();
    }

    if (task.isFavorite && !_favoriteTasks.contains(task)) {
      _favoriteTasks.add(task);
      _saveFavoriteTasks();
    }

    notifyListeners();
  }

  void removeTask(Task task) {
    _tasks.remove(task);
    _favoriteTasks.removeWhere((favoriteTask) => favoriteTask.id == task.id);
    _saveTasks();
    _saveFavoriteTasks();
    notifyListeners();
  }

void updateTask(Task updatedTask) {
  final existingTaskIndex = _tasks.indexWhere((task) => task.id == updatedTask.id);
  
  if (existingTaskIndex != -1) {
    final existingTask = _tasks[existingTaskIndex];
    final existingTaskIsFavorite = existingTask.isFavorite;

    _tasks[existingTaskIndex] = updatedTask;

    if (existingTaskIsFavorite) {
      final existingFavoriteIndex = _favoriteTasks.indexWhere((task) => task.id == updatedTask.id);
      if (existingFavoriteIndex != -1) {
        _favoriteTasks[existingFavoriteIndex] = updatedTask;
      }
    }

    _saveTasks();
    _saveFavoriteTasks();
    notifyListeners();
  }
}

 void completeTask(int index, bool isCompleted) {
    final task = _tasks[index];
    task.isCompleted = isCompleted;

    if (task.isFavorite) {
      final correspondingTask = _favoriteTasks.firstWhere((t) => t == task);
      correspondingTask.isCompleted = isCompleted;
    }

    _saveTasks();
    notifyListeners();
  }

  List<Task> getTasksForToday() {
    final today = DateTime.now();
    final todayTasks = _tasks.where((task) {
      final taskDate = task.dueDate;
      return taskDate.year == today.year &&
          taskDate.month == today.month &&
          taskDate.day == today.day;
    }).toList();

    return todayTasks;
  }

  bool areAllTasksCompleted() {
    return _tasks.isNotEmpty && _tasks.every((task) => task.isCompleted);
  }

  void toggleAllTasksCompleted(bool isCompleted) {
    for (var task in _tasks) {
      task.isCompleted = isCompleted;
    }

    for (var favoriteTask in _favoriteTasks) {
      favoriteTask.isCompleted = isCompleted;
    }

    _saveTasks();
    _saveFavoriteTasks();
    notifyListeners();
  }

bool isTaskFavorite(Task task) {
  return _favoriteTasks.contains(task);
}
  void toggleFavorite(Task task) {
  if (_favoriteTasks.contains(task)) {
    _favoriteTasks.remove(task);
  } else {
    _favoriteTasks.add(task);
  }
  _saveFavoriteTasks();
  notifyListeners();
}
  
int getTasksCountForToday() {
  final today = DateTime.now();
  final todayTasks = _tasks.where((task) {
    final taskDate = task.dueDate;
    return taskDate.year == today.year &&
        taskDate.month == today.month &&
        taskDate.day == today.day;
  }).toList();

  return todayTasks.length;
}

List<Task> getUpcomingTasks() {
  final tomorrow = DateTime.now().add(Duration(days: 1));
  final upcomingTasks = _tasks.where((task) {
    final taskDate = task.dueDate;
    return taskDate.isAfter(tomorrow) && taskDate.difference(tomorrow).inDays <= 2;
  }).toList();

  return upcomingTasks;
}

}
