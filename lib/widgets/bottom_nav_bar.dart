import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/cubit/todo_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return BlocBuilder<TodoCubit, TodoState>(
      builder: (context, state) {
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
                _navTab(context, 0, "All", todoCubit),
                _navTab(context, 1, "Pending", todoCubit),
                _navTab(context, 2, "Completed", todoCubit),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _navTab(
    BuildContext context,
    int index,
    String title,
    TodoCubit todoCubit,
  ) {
    return GestureDetector(
      onTap: () {
        todoCubit.changeTab(index);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        width: 100,
        height: 31,
        decoration: BoxDecoration(
          color: todoCubit.selectedTab == index
              ? Colors.black
              : Colors.transparent,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: todoCubit.selectedTab == index
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
