import 'package:note/data/task_type.dart';
import 'package:note/data/task_type_enum.dart';

List<TaskType> getTaskTypeList() {
  var list = [
    TaskType(
      image: 'images/banking.png',
      title: 'کار بانکی',
      taskTypeEnum: TaskTypeEnum.banking,
    ),
    TaskType(
      image: 'images/date.png',
      title: 'قرار کاری',
      taskTypeEnum: TaskTypeEnum.date,
    ),
    TaskType(
      image: 'images/meditate.png',
      title: 'مدیتیشن',
      taskTypeEnum: TaskTypeEnum.meditation,
    ),
    TaskType(
      image: 'images/meeting.png',
      title: 'بیرون با رفیقا',
      taskTypeEnum: TaskTypeEnum.meeting,
    ),
    TaskType(
      image: 'images/sport.png',
      title: 'ورزش',
      taskTypeEnum: TaskTypeEnum.sport,
    ),
    TaskType(
      image: 'images/working.png',
      title: 'برنامه نویسی',
      taskTypeEnum: TaskTypeEnum.working,
    ),
  ];

  return list;
}
