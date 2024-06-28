import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/tasks/data/local_tasks_datasource.dart';
import 'core/tasks/domain/repositories/tasks_local_repository.dart';
import 'core/tasks/domain/repositories/tasks_repository.dart';
import 'feature/tasks/bloc/task_cubit.dart';
import 'feature/tasks/presentation/tasks_page.dart';

class MyApp extends StatelessWidget {
  const MyApp._({super.key});

  static Future<void> initializeAndRun() async {
    WidgetsFlutterBinding.ensureInitialized();

    /// Initialize Hive
    await Hive.initFlutter();

    /// Initialize the local data source
    await LocalTasksDatasource.init();

    /// Run the app
    runApp(MyApp._(key: UniqueKey()));
  }

  @override
  Widget build(BuildContext context) {
    /// Provide the repository and the bloc to the app
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TasksRepository>(
          create: (c) => TasksLocalRepository(LocalTasksDatasource()),
          // create: (c) => TasksMockRepository(MockTasksDatasource()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (c) => TaskCubit(c.read<TasksRepository>()),
          ),
        ],
        child: const MaterialApp(
          title: 'Flutter Task Manager',
          home: TasksPage(),
        ),
      ),
    );
  }
}
