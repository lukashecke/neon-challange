import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neon/feature/age_estimation/data/age_estimation_repository.dart';

part 'age_estimation_event.dart';
part 'age_estimation_state.dart';

/// The bloc for the age estimation feature.
class AgeEstimationBloc extends Bloc<AgeEstimationEvent, AgeEstimationState> {
  /// This is the main age estimation bloc constructor.
  AgeEstimationBloc({required AgeEstimationRepository repository})
      : _repository = repository,
        super(AgeEstimationInitial()) {
    on<NameEntered>((event, emit) async {
      if (event.name.isEmpty) {
        emit(AgeEstimationError());
        return;
      }
      emit(AgeEstimationLoading());

      try {
        final ageEstimation = await _repository.fetchNameEstimation(event.name);
        emit(
          AgeEstimationLoaded(
            ageEstimation.age ?? 0,
            ageEstimation.name ?? '-',
          ),
        );
      } on Exception catch (error, stackTrace) {
        log(
          'Exception cought in AgeEstimationBloc.on<NameEntered>',
          error: error,
          stackTrace: stackTrace,
        );
        emit(AgeEstimationError());
      }
    });
  }

  final AgeEstimationRepository _repository;
}
