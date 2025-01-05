part of 'age_estimation_bloc.dart';

@immutable

/// The event of the age estimation feature.
sealed class AgeEstimationEvent {}

/// The event to enter the name to estimate the age of.
final class NameEntered extends AgeEstimationEvent {
  /// This is the main name entered event constructor.
  NameEntered(this.name);

  /// The name to estimate the age of.
  final String name;
}

/// The event to estimate the age of the name.
final class EstimateAge extends AgeEstimationEvent {}

/// The event to reset the age estimation.
final class ResetAgeEstimation extends AgeEstimationEvent {}
