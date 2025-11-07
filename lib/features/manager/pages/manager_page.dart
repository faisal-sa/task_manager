import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/bloc/manager_state.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/features/manager/widgets/add_task_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ManagerPage extends StatelessWidget {
  const ManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManagerBloc, ManagerState>(
      builder: (context, state) => state.when(
        initial: () => Center(child: Text("Welcome")),
        loading: () => Center(child: CircularProgressIndicator()),
        loaded: (name, projects) => Scaffold(
          appBar: AppBar(
            leading: Icon(Icons.person),
            title: Text("Hello $name"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    backgroundColor: Colors.white,
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => BlocProvider.value(
                      value: BlocProvider.of<ManagerBloc>(context),
                      child: const AddTaskModal(),
                    ),
                  );
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
