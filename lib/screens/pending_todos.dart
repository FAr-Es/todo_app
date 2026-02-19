import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/blocs/cubit/todo_cubit.dart';
import 'package:todo_app/widgets/bottom_nav_bar.dart';

class PendingTodos extends StatefulWidget {
  const PendingTodos({super.key});

  @override
  State<PendingTodos> createState() => _PendingTodosState();
}

class _PendingTodosState extends State<PendingTodos> {
  String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: Padding(
        padding: const EdgeInsets.only(top: 84, left: 11, right: 0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pending',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w700,
                        fontSize: 34,
                      ),
                    ),
                    Text(
                      DateFormat('MMMM d').format(DateTime.now()),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color.fromARGB(255, 138, 138, 138),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 171),
                  child: Container(
                    width: 42,
                    height: 42,
                    child: Image.asset("assets/icons/pending_icon.png"),
                  ),
                ),
              ],
            ),
            SizedBox(height: 97),
            Expanded(
              child: BlocBuilder<TodoCubit, TodoState>(
                builder: (context, state) => ListView.builder(
                  itemCount: todoCubit.pendingTodos.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = todoCubit.pendingTodos[index];
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.title,
                            style: TextStyle(
                              decoration: item.isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: item.isChecked
                                  ? Color.fromARGB(255, 209, 209, 209)
                                  : Color.fromARGB(255, 115, 115, 115),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            formatTimeOfDay(item.time),
                            style: TextStyle(
                              decoration: item.isChecked
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              color: item.isChecked
                                  ? Color.fromARGB(255, 209, 209, 209)
                                  : Color.fromARGB(255, 163, 163, 163),
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      leading: SizedBox(
                        width: 21.55,
                        height: 20,
                        child: Transform.scale(
                          scale: 1.1,
                          child: Checkbox(
                            value: item.isChecked,
                            shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(2),
                            ),
                            side: const BorderSide(
                              color: Color.fromARGB(255, 232, 232, 232),
                              width: 1,
                            ),
                            activeColor: Color.fromARGB(255, 0, 128, 128),
                            onChanged: (val) {
                              todoCubit.toggleCompleted(item.id);
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // bottom navigation bar
            BottomNavBar(),
          ],
        ),
      ),
    );
  }
}
