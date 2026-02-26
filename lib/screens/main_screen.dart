import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/cubit/todo_cubit.dart';
import 'package:todo_app/screens/home_screen.dart';
import 'package:todo_app/screens/pending_todos.dart';
import 'package:todo_app/screens/completed_todos.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: todoCubit.selectedTab,
            children: const [
              HomeScreen(),
              PendingTodos(),
              CompletedTodos(),
            ],
          ),
        );
      },
    );
  }
}