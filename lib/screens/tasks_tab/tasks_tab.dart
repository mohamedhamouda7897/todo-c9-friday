import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9_friday/screens/tasks_tab/task_item.dart';
import 'package:todo_c9_friday/shared/network/firebase_functions.dart';
import 'package:todo_c9_friday/shared/styles/colors.dart';

class TasksTab extends StatefulWidget {
  TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  var selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CalendarTimeline(
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(
            days: 365,
          )),
          onDateSelected: (date) {
            selectedDate = date;
            setState(() {});
          },
          leftMargin: 21,
          monthColor: primaryColor,
          dayColor: Colors.blue.withOpacity(.5),
          activeDayColor: Colors.white,
          activeBackgroundDayColor: primaryColor,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFunctions.getTasksFromFirestore(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"));
              }

              var tasks =
                  snapshot.data?.docs.map((e) => e.data()).toList() ?? [];

              if (tasks.isEmpty) {
                return Center(child: Text("NO TASKS"));
              }
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
                itemCount: tasks.length,
              );
            },
          ),
        )
      ],
    );
  }
}
