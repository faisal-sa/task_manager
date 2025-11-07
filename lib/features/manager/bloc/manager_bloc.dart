import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'manager_event.dart';
import 'manager_state.dart';

class ManagerBloc extends Bloc<ManagerEvent, ManagerState> {
  final SupabaseClient client;

  ManagerBloc({required this.client}) : super(ManagerState.initial()) {
    on<ManagerEvent>((event, emit) async {
      await event.when(
        initialize: () async {
          print("initializing now");

          emit(ManagerState.loaded(name: "manager"));
        },
      );
    });
  }
}
