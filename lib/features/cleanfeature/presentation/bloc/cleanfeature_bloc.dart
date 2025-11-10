import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'cleanfeature_event.dart';
part 'cleanfeature_state.dart';

class CleanfeatureBloc extends Bloc<CleanfeatureEvent, CleanfeatureState> {
  CleanfeatureBloc() : super(CleanfeatureInitial()) {
    on<CleanfeatureEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
