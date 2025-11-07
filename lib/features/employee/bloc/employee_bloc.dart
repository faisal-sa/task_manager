import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'employee_event.dart';
import 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final SupabaseClient client;

  EmployeeBloc({required this.client}) : super(EmployeeState.initial()) {
    on<EmployeeEvent>((event, emit) async {
      await event.when(
        initialize: () async {
          print("initializing now");
          emit(EmployeeState.loading());
        },
      );
    });
  }
}
