import '../../data/mock_tasks_datasource.dart';
import '../entities/task_entity.dart';
import 'tasks_repository.dart';

/// The mock repository for tasks
class TasksMockRepository implements TasksRepository {
  TasksMockRepository(this.datasource);

  final MockTasksDatasource datasource;

  @override
  Future<void> addTask(TaskEntity task) {
    return datasource.addTask(task);
  }

  @override
  List<TaskEntity> getTasks() {
    return datasource.getTasks();
  }

  @override
  Future<void> removeTask(TaskEntity task) {
    return datasource.removeTask(task);
  }

  @override
  Future<void> updateTask(TaskEntity task) {
    return datasource.updateTask(task);
  }
}
