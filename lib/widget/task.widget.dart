import 'package:flutter/material.dart';
import 'package:note/screen/edit_task_screen.dart';
import 'package:note/data/task.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  bool isCheacked = false;

  @override
  void initState() {
    super.initState();
    isCheacked = widget.task.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return _getTaskItem();
  }

  Widget _getTaskItem() {
    return InkWell(
      onTap: () {
        setState(() {
          isCheacked = !isCheacked;
          widget.task.isDone = isCheacked;
          widget.task.save();
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: _getWholeContent(),
      ),
    );
  }

  Padding _getWholeContent() {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.scale(
                      scale: 1.6,
                      child: Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        activeColor: Colors.teal,
                        value: isCheacked,
                        onChanged: (selected) {},
                      ),
                    ),
                    Text(
                      widget.task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  widget.task.subTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                Spacer(),
                _getMainContent(),
                SizedBox(height: 8)
              ],
            ),
          ),
          SizedBox(width: 10),
          Image.asset(widget.task.taskType.image),
        ],
      ),
    );
  }

  Widget _getMainContent() {
    return Row(
      children: [
        Container(
          width: 85,
          height: 28,
          decoration: BoxDecoration(
            color: Color(0xff18DAA3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: [
                Text(
                  '${HourUnder10(widget.task.time)} : ${MinuteUnder10(widget.task.time)}',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Image.asset('images/icon_time.png'),
              ],
            ),
          ),
        ),
        SizedBox(width: 8),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return EditTaskScreen(
                    task: widget.task,
                  );
                },
              ),
            );
          },
          child: Container(
            width: 85,
            height: 28,
            decoration: BoxDecoration(
              color: Color(0xffE2F6F1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  Text(
                    'ویرایش',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Transform.scale(
                    scale: 1.2,
                    child: Image.asset('images/icon_edit.png'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String MinuteUnder10(DateTime time) {
    if (time.minute < 10) {
      return '0${time.minute}';
    } else {
      return time.minute.toString();
    }
  }

  String HourUnder10(DateTime time) {
    if (time.hour < 10) {
      return '0${time.hour}';
    } else {
      return time.hour.toString();
    }
  }
}
