import '../entities/task_entity.dart';

/// The repository for tasks
abstract interface class TasksRepository {
  List<TaskEntity> getTasks();

  Future<void> addTask(TaskEntity task);

  Future<void> removeTask(TaskEntity task);

  Future<void> updateTask(TaskEntity task);
}
