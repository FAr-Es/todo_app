import 'package:flutter/material.dart';

class TodoItem {
  final String title;
  final int id;
  final TimeOfDay time;
  bool isChecked;
  String category;
  String date;

  TodoItem({
    required this.title,
    required this.id,
    required this.time,
    this.isChecked = false,
    required this.category,
    required this.date,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'id': id,
      'hour': time.hour,
      'minute': time.minute,
      'isChecked': isChecked,
      'category': category,
      "date": date,
    };
  }
}
