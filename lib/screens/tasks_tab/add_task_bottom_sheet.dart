import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_c9_friday/models/task_model.dart';
import 'package:todo_c9_friday/shared/network/firebase_functions.dart';
import 'package:todo_c9_friday/shared/styles/colors.dart';
import 'package:todo_c9_friday/shared/styles/themeing.dart';

class AddTaskBottomSheet extends StatefulWidget {
  AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  DateTime selectedDate = DateTime.now();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Add New Task",
            textAlign: TextAlign.center,
            style:
                Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 22),
          ),
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor)),
                labelText: "Task Title"),
          ),
          SizedBox(
            height: 22,
          ),
          TextFormField(
            controller: descriptionController,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: primaryColor)),
                labelText: "Task Description"),
          ),
          SizedBox(
            height: 22,
          ),
          Text("Select Date",
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.bodySmall),
          InkWell(
            onTap: () {
              showPicker(context: context);
            },
            child: Text(
              "${selectedDate.toString().substring(0, 10)}",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
          ElevatedButton(
              onPressed: () {
                TaskModel task = TaskModel(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    title: titleController.text,
                    description: descriptionController.text,
                    date: DateUtils.dateOnly(selectedDate)
                        .millisecondsSinceEpoch);

                print(selectedDate);
                FirebaseFunctions.addTask(task);
                Navigator.pop(context);
              },
              child: Text("Add Task"))
        ],
      ),
    );
  }

  showPicker({required BuildContext context}) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));

    if (chosenDate == null) return;
    selectedDate = chosenDate;
    setState(() {});
  }

// SELECT * FROM TABLE NAME where
// "INSERT int TAble name value()"
}
