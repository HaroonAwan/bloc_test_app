import '../../data/local_tasks_datasource.dart';
import '../entities/task_entity.dart';
import 'tasks_repository.dart';

/// The local repository for tasks
class TasksLocalRepository implements TasksRepository {
  TasksLocalRepository(this.localTasksDatasource);

  final LocalTasksDatasource localTasksDatasource;

  @override
  Future<void> addTask(TaskEntity task) {
    return localTasksDatasource.addTask(task);
  }

  @override
  List<TaskEntity> getTasks() {
    return localTasksDatasource.getTasks();
  }

  @override
  Future<void> removeTask(TaskEntity task) {
    return localTasksDatasource.removeTask(task);
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    return localTasksDatasource.updateTask(task);
  }
}
