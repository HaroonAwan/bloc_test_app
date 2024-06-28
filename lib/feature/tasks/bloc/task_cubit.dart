import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/tasks/domain/entities/task_entity.dart';
import '../../../core/tasks/domain/repositories/tasks_repository.dart';

part 'task_cubit.freezed.dart';
part 'task_state.dart';

/// The task cubit for state management
class TaskCubit extends Cubit<TaskState> {
  TaskCubit(this.tasksRepository) : super(TaskState.initial());

  final TasksRepository tasksRepository;

  Future<void> getAllTasks() async {
    try {
      final tasks = tasksRepository.getTasks();
      emit(state.copyWith(isLoading: false, tasks: [...tasks], error: null));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> addTask(TaskEntity task) async {
    try {
      await tasksRepository.addTask(task);
      await getAllTasks();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateTask(TaskEntity task) async {
    try {
      await tasksRepository.updateTask(task);
      await getAllTasks();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(TaskEntity task) async {
    try {
      await tasksRepository.removeTask(task);
      await getAllTasks();
    } catch (e) {
      rethrow;
    }
  }
}
