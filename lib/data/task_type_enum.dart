import 'package:hive/hive.dart';

part 'task_type_enum.g.dart';

@HiveType(typeId: 3)
enum TaskTypeEnum {
  @HiveField(0)
  banking,
  @HiveField(1)
  date,
  @HiveField(2)
  meditation,
  @HiveField(3)
  meeting,
  @HiveField(4)
  sport,
  @HiveField(5)
  working,
}
