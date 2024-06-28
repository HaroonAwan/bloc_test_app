import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/tasks/domain/entities/task_entity.dart';
import '../../../shared/utils/nav.dart';
import '../bloc/task_cubit.dart';

/// The page to add or update a task
class AddTaskPage extends StatefulWidget {
  const AddTaskPage({
    super.key,
    this.task,
  });

  final TaskEntity? task;

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _key = GlobalKey<FormState>();
  var _autoValidateMode = AutovalidateMode.disabled;
  final _titleController = TextEditingController();

  bool get _isEditing => widget.task != null;

  OutlineInputBorder get _border {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.grey),
    );
  }

  @override
  void initState() {
    super.initState();
    if (_isEditing) {
      _titleController.text = widget.task?.title ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_isEditing ? 'Update Task' : 'Add Task')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _key,
          autovalidateMode: _autoValidateMode,
          child: Column(children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: _border,
                enabledBorder: _border,
                focusedBorder: _border,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 6,
                  vertical: 4,
                ),
              ),
              validator: (v) => v!.isEmpty ? 'Title is required' : null,
            ),
            const SizedBox(height: 12),
            FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(47),
              ),
              onPressed: _save,
              child: Text(_isEditing ? 'Update' : 'Save'),
            )
          ]),
        ),
      ),
    );
  }

  void _save() async {
    if (!_key.currentState!.validate()) {
      _autoValidateMode = AutovalidateMode.onUserInteraction;
      setState(() {});
      return;
    }
    try {
      final taskCubit = context.read<TaskCubit>();
      if (_isEditing) {
        widget.task?.title = _titleController.text.trim();
        await taskCubit.updateTask(widget.task!);
      } else {
        final task = TaskEntity(
          title: _titleController.text.trim(),
          date: DateTime.now(),
        );
        await taskCubit.addTask(task);
      }
      if (!mounted) return;
      AppNavigation.pop(context);
    } catch (_) {}
  }
}
