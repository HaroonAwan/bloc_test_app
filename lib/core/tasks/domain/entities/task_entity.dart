import 'package:hive/hive.dart';

part 'task_entity.g.dart';

/// Entity for the tasks
@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  TaskEntity({
    required this.title,
    required this.date,
  });

  @HiveField(0)
  String title;
  @HiveField(1)
  final DateTime date;

  @override
  String toString() {
    return 'TaskEntity{title: $title, date: $date}';
  }

  @override
  bool operator ==(Object other) {
    return other is TaskEntity && other.title == title && other.date == date;
  }

  @override
  int get hashCode => title.hashCode ^ date.hashCode;
}
