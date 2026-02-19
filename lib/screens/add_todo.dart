import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/blocs/cubit/todo_cubit.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({super.key});

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  @override
  Widget build(BuildContext context) {
    final todoCubit = context.read<TodoCubit>();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 245, 245),
      body: SafeArea(
        child: BlocBuilder<TodoCubit, TodoState>(
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 49),
                        child: Text(
                          "Add a task",
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w700,
                            fontSize: 34,
                          ),
                        ),
                      ),
                      SizedBox(height: 97),

                      //title
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 84,
                          right: 83,
                          bottom: 48,
                        ),
                        child: TextFormField(
                          controller: todoCubit.taskNameController,
                          decoration: InputDecoration(
                            hintText: "Name your task",
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 196, 196, 196),
                              ),
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.89,
                              color: Color.fromARGB(255, 204, 204, 204),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      // category
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 84,
                          right: 83,
                          bottom: 48,
                        ),
                        child: TextFormField(
                          controller: todoCubit.categoryController,
                          readOnly: true,
                          onTap: () {
                            todoCubit.toggleCategories();
                          },
                          decoration: InputDecoration(
                            hintText: "Choose a category",
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 196, 196, 196),
                              ),
                            ),
                            suffixIcon: Icon(
                              todoCubit.showCategories
                                  ? Icons.arrow_drop_up
                                  : Icons.arrow_drop_down,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.89,
                              color: Color.fromARGB(255, 204, 204, 204),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      //date
                      Padding(
                        padding: const EdgeInsets.only(left: 84, right: 83),
                        child: TextFormField(
                          controller: todoCubit.dateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2027),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                              todoCubit.dateController.text = formattedDate;
                            }
                          },
                          decoration: InputDecoration(
                            focusColor: Colors.red,
                            hintText: "MM/DD/YY",
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(255, 196, 196, 196),
                              ),
                            ),
                            border: const UnderlineInputBorder(),
                            suffixIcon: Image.asset(
                              "assets/icons/Date_range_light.png",
                            ),
                            hintStyle: TextStyle(
                              fontSize: 12.89,
                              color: Color.fromARGB(255, 204, 204, 204),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 237),
                      SizedBox(
                        width: 316,
                        height: 46.32,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(11.58),
                            ),
                          ),
                          onPressed: () {
                            String taskName = todoCubit.taskNameController.text
                                .trim();
                            String category = todoCubit.categoryController.text
                                .trim();
                            String date = todoCubit.dateController.text.trim();

                            if (taskName.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please enter a task name"),
                                ),
                              );
                              return;
                            }

                            if (category.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Please choose a category"),
                                ),
                              );
                              return;
                            }

                            if (date.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Please select a date")),
                              );
                              return;
                            }

                            todoCubit.addTodo();

                            todoCubit.taskNameController.clear();
                            todoCubit.categoryController.clear();
                            todoCubit.dateController.clear();

                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              fontSize: 14.06,
                              fontWeight: FontWeight.w500,
                              letterSpacing: -0.34,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                if (todoCubit.showCategories)
                  Positioned(
                    top: 400,
                    left: 154,
                    right: 83,
                    child: Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            _categoryItem(
                              "Personal",
                              "assets/icons/personal.png",
                              Color(0xFFEEEBFF),
                              Color(0xFF4DB6AC),
                              todoCubit,
                            ),
                            _categoryItem(
                              "Work",
                              "assets/icons/work.png",
                              Color(0xFFE8F0FF),
                              Color(0xFF42A5F5),
                              todoCubit,
                            ),
                            _categoryItem(
                              "Health",
                              "assets/icons/health.png",
                              Color(0xFFFFEBEE),
                              Color(0xFFEF5350),
                              todoCubit,
                            ),
                            _categoryItem(
                              "Family",
                              "assets/icons/family.png",
                              Color(0xFFFFF8E1),
                              Color(0xFF212121),
                              todoCubit,
                            ),
                            _categoryItem(
                              "Learning",
                              "assets/icons/education.png",
                              Color(0xFFFFF3E0),
                              Color(0xFFFFA726),
                              todoCubit,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _categoryItem(
    String category,
    String iconName,
    Color iconBgColor,
    Color textColor,
    TodoCubit todocubit,
  ) {
    return ListTile(
      leading: Container(width: 44, height: 44, child: Image.asset(iconName)),
      title: Text(
        category,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
      onTap: () {
        todocubit.categoryController.text = category;
        todocubit.hideCategories();
      },
    );
  }
}
