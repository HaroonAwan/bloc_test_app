import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tasks/domain/entities/task_entity.dart';
import '../../../shared/modals/confirmation_modal.dart';
import '../../../shared/utils/nav.dart';
import '../bloc/task_cubit.dart';
import 'add_task_page.dart';

/// The page to display tasks
class TasksPage extends StatefulWidget {
  const TasksPage({super.key});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  @override
  void initState() {
    super.initState();
    context.read<TaskCubit>().getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppNavigation.toPage(context, const AddTaskPage());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (_, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.hasError) {
            return Center(child: Text(state.error!));
          } else {
            if (!state.hasTasks) {
              return const Center(child: Text('No tasks available.'));
            } else {
              return ListView.builder(
                itemBuilder: (_, i) => _itemBuilder(state.tasks[i]),
                itemCount: state.tasks.length,
              );
            }
          }
        },
      ),
    );
  }

  Widget _itemBuilder(TaskEntity task) {
    return ListTile(
      onTap: () {
        AppNavigation.toPage(context, AddTaskPage(task: task));
      },
      title: Text(task.title),
      trailing: IconButton(
        icon: const Icon(Icons.delete, color: Colors.red),
        onPressed: () async {
          /// The confirmation dialog before deleting task
          final result = await const ConfirmationDialog(
            body: 'Are you sure you want to delete this task?',
          ).show(context);
          if (!result) return;
          if (!mounted) return;
          context.read<TaskCubit>().deleteTask(task);
        },
      ),
    );
  }
}
