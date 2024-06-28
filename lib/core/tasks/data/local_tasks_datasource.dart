import 'package:hive_flutter/hive_flutter.dart';

import '../domain/entities/task_entity.dart';

/// The local data source for tasks using Hive as the local database
class LocalTasksDatasource {
  /// The Hive box for tasks
  static late Box<TaskEntity> _box;

  static Future<void> init() async {
    Hive.registerAdapter(TaskEntityAdapter());
    _box = await Hive.openBox<TaskEntity>('tasks');
  }

  Future<void> addTask(TaskEntity task) async {
    await _box.add(task);
    await task.save();
  }

  List<TaskEntity> getTasks() {
    return _box.values.toList();
  }

  Future<void> removeTask(TaskEntity task) async {
    await task.delete();
  }

  Future<void> updateTask(TaskEntity task) async {
    await task.save();
  }
}
