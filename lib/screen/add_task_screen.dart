import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:note/data/task.dart';
import 'package:note/data/task_type.dart';
import 'package:note/widget/task_type_item_list.dart';
import 'package:note/utility/utility.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  FocusNode focus = FocusNode();
  FocusNode focus2 = FocusNode();

  TextEditingController controllerTaskTitle = TextEditingController();
  TextEditingController controllerTaskSubTitle = TextEditingController();

  var box = Hive.box<Task>('taskBox');

  DateTime? _time;

  int _selecktedTaskTypeItem = 0;

  @override
  void initState() {
    super.initState();
    focus.addListener(() {
      setState(() {});
    });
    focus2.addListener(() {
      setState(() {});
    });
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
                            fontSize: 17,
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
                                  fontSize: 17,
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
                      String taskTitle = controllerTaskTitle.text;
                      String taskSubTitle = controllerTaskSubTitle.text;
                      AddTask(taskTitle, taskSubTitle);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'اضافه کردن فعالیت',
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

  AddTask(String taskTitle, String taskSubTitle) {
    var task = Task(
        title: taskTitle,
        subTitle: taskSubTitle,
        time: _time!,
        taskType: getTaskTypeList()[_selecktedTaskTypeItem]);
    box.add(task);
  }
}
