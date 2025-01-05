part of 'age_estimation_bloc.dart';

@immutable

/// The state of the age estimation feature.
sealed class AgeEstimationState {}

/// The initial (and retry) state of the age estimation feature.
final class AgeEstimationInitial extends AgeEstimationState {}

/// The loading state of the age estimation feature.
final class AgeEstimationLoading extends AgeEstimationState {}

/// The loaded state of the age estimation feature.
final class AgeEstimationLoaded extends AgeEstimationState {
  /// This is the main loaded state constructor.
  AgeEstimationLoaded(this.age);

  /// The estimated age of the name.
  final int age;
}

/// The error state of the age estimation feature.
final class AgeEstimationError extends AgeEstimationState {}
