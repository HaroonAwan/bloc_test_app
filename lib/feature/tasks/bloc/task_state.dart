part of 'task_cubit.dart';

/// The state for the task cubit
@freezed
class TaskState with _$TaskState {
  TaskState._();

  factory TaskState({
    required List<TaskEntity> tasks,
    required bool isLoading,
    String? error,
  }) = _TaskState;

  factory TaskState.initial() {
    return TaskState(
      tasks: [],
      isLoading: true,
      error: null,
    );
  }

  bool get hasError => error != null;

  bool get hasTasks => tasks.isNotEmpty;
}
