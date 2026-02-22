import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/models/todo_item.dart';

class TodoStorage {
  Future<void> addTodoStorage(TodoItem todo) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final existing = pref.getStringList('todo') ?? [];
    existing.add(jsonEncode(todo.toMap()));
    await pref.setStringList('todo', existing);
  }

  Future<List<TodoItem>> getTodoStorage() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final List<String> items = pref.getStringList('todo') ?? [];
    return items.map((item) {
      final map = jsonDecode(item);
      return TodoItem(
        title: map['title'],
        id: map['id'],
        time: TimeOfDay(hour: map['hour'], minute: map['minute']),
        isChecked: map['isChecked'],
      );
    }).toList();
  }

  Future<void> updateTodoStorage(List<TodoItem> todos) async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  final items = todos.map((todo) => jsonEncode(todo.toMap())).toList();
  await pref.setStringList('todo', items);
}
}
