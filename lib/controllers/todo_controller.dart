import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoController extends ChangeNotifier {
  final List<TodoItem> _todos = [];
  List<TodoItem> get todos => _todos;
  List<TodoItem> get pendingTodos {
  return todos.where((todo) => !todo.isChecked).toList();
}
  List<TodoItem> get completedTodos {
  return todos.where((todo) => todo.isChecked).toList();
}
  
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  int selectedTab = 0;
  bool showCategories = false;


  void addTodo() {
    final title = taskNameController.text;
    final nowTime = DateTime.now().toUtc().microsecondsSinceEpoch;
    final now = DateTime.now();
    if (title.trim().isEmpty) return;
    final newTodo = TodoItem(
      title: title,
      isChecked: false,
      id: nowTime,
      time: TimeOfDay(hour: now.hour, minute: now.minute),
    );
    _todos.add(newTodo);

    notifyListeners();
  }

  void reomveTodo(int id) {
    _todos.removeWhere((item) => item.id == id);
  }

  void toggleCompleted(int id) {
    final item = _todos.firstWhere((item) => item.id == id);
    item.isChecked = !item.isChecked;
    notifyListeners();
  }

  void changeTab(int index){
    selectedTab = index;
    notifyListeners();
  }

 void toggleCategories() {
  showCategories = !showCategories;
  notifyListeners();
}

void hideCategories() {
  showCategories = false;
  notifyListeners();
}
}
