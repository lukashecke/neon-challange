import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'age_estimation_event.dart';
part 'age_estimation_state.dart';

class AgeEstimationBloc extends Bloc<AgeEstimationEvent, AgeEstimationState> {
  AgeEstimationBloc() : super(AgeEstimationInitial()) {
    on<AgeEstimationEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
