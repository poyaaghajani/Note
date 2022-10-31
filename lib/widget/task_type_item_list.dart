import 'package:flutter/material.dart';
import 'package:note/data/task_type.dart';

class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList(
      {Key? key,
      required this.taskType,
      required this.selecktedTaskTypeItem,
      required this.index})
      : super(key: key);

  TaskType taskType;

  int selecktedTaskTypeItem;
  int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      width: 140,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal, width: 1.5),
        color:
            (selecktedTaskTypeItem == index) ? Colors.teal : Color(0xffE2F6F1),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image),
          SizedBox(height: 5),
          Text(
            taskType.title,
            style: TextStyle(
              color: (selecktedTaskTypeItem == index)
                  ? Color(0xffE2F6F1)
                  : Colors.teal,
            ),
          ),
        ],
      ),
    );
  }
}
