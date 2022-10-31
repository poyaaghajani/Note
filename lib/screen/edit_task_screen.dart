import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/data/task.dart';
import 'package:note/utility/utility.dart';
import 'package:note/widget/task_type_item_list.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({Key? key, required this.task}) : super(key: key);
  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode focus = FocusNode();
  FocusNode focus2 = FocusNode();

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  var box = Hive.box<Task>('taskBox');

  DateTime? _time;

  int _selecktedTaskTypeItem = 0;

  @override
  void initState() {
    super.initState();

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

    focus.addListener(() {
      setState(() {});
    });
    focus2.addListener(() {
      setState(() {});
    });

    var index = getTaskTypeList().indexWhere((element) {
      return element.taskTypeEnum == widget.task.taskType.taskTypeEnum;
    });

    _selecktedTaskTypeItem = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(top: 10),
            child: SizedBox(
              height: 745,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: TextField(
                        controller: controllerTaskTitle,
                        style: TextStyle(color: Colors.black),
                        focusNode: focus,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 14),
                          labelText: 'عنوان',
                          labelStyle: TextStyle(
                            color: focus.hasFocus
                                ? Color(0xff18DAA3)
                                : Colors.grey,
                            fontSize: 16,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                              color: Color(0xffC5C5C5),
                              width: 3,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            borderSide: BorderSide(
                              width: 3,
                              color: Color(0xff18DAA3),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14),
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: TextField(
                              controller: controllerTaskSubTitle,
                              maxLines: 2,
                              style: TextStyle(color: Colors.black),
                              focusNode: focus2,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 14),
                                labelText: 'توضیح',
                                labelStyle: TextStyle(
                                  color: focus2.hasFocus
                                      ? Color(0xff18DAA3)
                                      : Colors.grey,
                                  fontSize: 16,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                    color: Color(0xffC5C5C5),
                                    width: 3,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  borderSide: BorderSide(
                                    width: 3,
                                    color: Color(0xff18DAA3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: CustomHourPicker(
                      title: 'زمان فعالیت را انتخاب کن',
                      titleStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      negativeButtonText: 'حذف',
                      negativeButtonStyle: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      positiveButtonText: 'انتخاب',
                      positiveButtonStyle: TextStyle(
                        color: Color(0xff18DAA3),
                        fontWeight: FontWeight.bold,
                      ),
                      elevation: 2,
                      onPositivePressed: (context, time) {
                        _time = time;
                      },
                      onNegativePressed: (context) {},
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: getTaskTypeList().length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            setState(() {
                              _selecktedTaskTypeItem = index;
                            });
                          },
                          child: TaskTypeItemList(
                            index: index,
                            selecktedTaskTypeItem: _selecktedTaskTypeItem,
                            taskType: getTaskTypeList()[index],
                          ),
                        );
                      },
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff18DAA3),
                      minimumSize: Size(170, 40),
                    ),
                    onPressed: () {
                      String taskTitle = controllerTaskTitle!.text;
                      String taskSubTitle = controllerTaskSubTitle!.text;
                      EditTask(taskTitle, taskSubTitle);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'ویرایش کردن فعالیت',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 13)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  EditTask(String taskTitle, String taskSubTitle) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSubTitle;
    widget.task.time = _time!;
    widget.task.taskType = getTaskTypeList()[_selecktedTaskTypeItem];
    widget.task.save();
  }
}
