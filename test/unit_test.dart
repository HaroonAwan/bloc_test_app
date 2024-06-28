import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_test_app/core/tasks/data/mock_tasks_datasource.dart';
import 'package:bloc_test_app/core/tasks/domain/entities/task_entity.dart';
import 'package:bloc_test_app/core/tasks/domain/repositories/tasks_mock_repository.dart';
import 'package:bloc_test_app/feature/tasks/bloc/task_cubit.dart';
import 'package:test/test.dart';

void main() {
  group(
    'Test start, get tasks, add task, remove task',
    () {
      late TaskCubit taskCubit;
      setUp(
        () => taskCubit = TaskCubit(
          TasksMockRepository(MockTasksDatasource()),
        ),
      );

      tearDown(() => taskCubit.close());

      test(
        'Start with Initial state',
        () {
          expect(taskCubit.state, TaskState.initial());
        },
      );

      blocTest<TaskCubit, TaskState>(
        'Get tasks',
        build: () => taskCubit,
        act: (bloc) => bloc.getAllTasks(),
        expect: () => <TaskState>[
          TaskState(
            tasks: [],
            isLoading: false,
            error: null,
          ),
        ],
      );

      blocTest<TaskCubit, TaskState>(
        'Add task',
        build: () => taskCubit,
        act: (bloc) => bloc.addTask(TaskEntity(
          title: 'First',
          date: DateTime(2024, 1, 1),
        )),
        expect: () => <TaskState>[
          TaskState(
            tasks: [
              TaskEntity(
                title: 'First',
                date: DateTime(2024, 1, 1),
              ),
            ],
            isLoading: false,
            error: null,
          ),
        ],
      );

      blocTest<TaskCubit, TaskState>(
        'Remove task',
        build: () => taskCubit,
        act: (bloc) => bloc.deleteTask(TaskEntity(
          title: 'First',
          date: DateTime(2024, 1, 1),
        )),
        expect: () => <TaskState>[
          TaskState(
            tasks: [],
            isLoading: false,
            error: null,
          ),
        ],
      );
    },
  );
}
