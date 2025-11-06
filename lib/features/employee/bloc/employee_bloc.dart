import 'package:bloc/bloc.dart';
import 'package:bloc_getit_supabase_project_abdualaziz_abbas_abdulaziz/core/services/auth_service.dart';
import 'package:equatable/equatable.dart';

part 'employee_event.dart';
part 'employee_state.dart';

class EmployeeBloc extends Bloc<EmployeeEvent, EmployeeState> {
  final AuthService authService;

  EmployeeBloc({required this.authService}) : super(EmployeeInitial()) {
    on<EmployeeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
