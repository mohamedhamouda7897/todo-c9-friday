import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_c9_friday/models/task_model.dart';
import 'package:todo_c9_friday/shared/network/firebase_functions.dart';
import 'package:todo_c9_friday/shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskModel taskModel;

  TaskItem(this.taskModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Slidable(
        startActionPane: ActionPane(motion: StretchMotion(), children: [
          SlidableAction(
              onPressed: (context) {
                FirebaseFunctions.deleteTask(taskModel.id);
              },
              label: "Delete",
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              )),
          SlidableAction(
            onPressed: (context) {},
            label: "Edit",
            icon: Icons.edit,
            backgroundColor: Colors.blue,
          ),
        ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 80,
                width: 4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor),
              ),
              SizedBox(
                width: 25,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskModel.title,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(taskModel.description,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontSize: 12))
                ],
              ),
              Spacer(),
              taskModel.isDone
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(.4),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("Done!"))
                  : InkWell(
                      onTap: () {
                        taskModel.isDone = true;
                        FirebaseFunctions.updateTask(taskModel);
                      },
                      child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
