import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controllers/todo_controller.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/pending_todos.dart';
import 'package:todo_app/screens/completed_todos.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoController>(
      builder: (context, todoController, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Container(
            height: 51,
            width: 385,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _navTab(context, 0, HomeScreen(), "All", todoController),
                _navTab(context, 1, PendingTodos(), "Pending", todoController),
                _navTab(context, 2, CompletedTodos(), "Completed", todoController),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navTab(BuildContext context, int index, Widget screen, String title, TodoController todoController) {
    return GestureDetector(
      onTap: () {
        todoController.changeTab(index);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: 100,
        height: 31,
        decoration: BoxDecoration(
          color: todoController.selectedTab == index
              ? Colors.black
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: todoController.selectedTab == index
                  ? Colors.white
                  : Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}