import '../domain/entities/task_entity.dart';

/// The mock data source for tasks
class MockTasksDatasource {
  static final _data = <TaskEntity>[];

  Future<void> addTask(TaskEntity task) async {
    _data.add(task);
  }

  List<TaskEntity> getTasks() {
    return _data;
  }

  Future<void> removeTask(TaskEntity task) async {
    _data.remove(task);
  }

  Future<void> updateTask(TaskEntity task) async {
    final index = _data.indexWhere((t) => t.title == task.title);
    _data[index] = task;
  }
}
