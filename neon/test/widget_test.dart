import 'package:flutter_test/flutter_test.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';

void main() {
  group('AgeEstimationBloc', () {
    late AgeEstimationBloc ageEstimationBloc;

    setUp(() {
      ageEstimationBloc = AgeEstimationBloc();
    });

    test('initial state is AgeEstimationInitial', () {
      expect(ageEstimationBloc.state, isA<AgeEstimationInitial>());
    });

    test('age estimation is shown when name is entered and button is pressed',
        () {
      final name = 'John Doe';
      ageEstimationBloc.add(NameEntered(name));
      ageEstimationBloc.add(EstimateAge());

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationLoading>(),
          isA<AgeEstimationLoaded>()
              .having((state) => state.age, 'age', isNonZero),
        ]),
      );
    });

    test('age estimation fails when name is empty', () {
      final name = '';
      ageEstimationBloc.add(NameEntered(name));
      ageEstimationBloc.add(EstimateAge());

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationLoading>(),
          isA<AgeEstimationError>(),
        ]),
      );
    });

    test('age estimation fails when name contains numbers', () {
      final name = 'John123';
      ageEstimationBloc.add(NameEntered(name));
      ageEstimationBloc.add(EstimateAge());

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationLoading>(),
          isA<AgeEstimationError>(),
        ]),
      );
    });

    test('age estimation fails when name contains special characters', () {
      final name = 'John@Doe';
      ageEstimationBloc.add(NameEntered(name));
      ageEstimationBloc.add(EstimateAge());

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationLoading>(),
          isA<AgeEstimationError>(),
        ]),
      );
    });

    test('age estimation succeeds with a valid name', () {
      final name = 'Jane Doe';
      ageEstimationBloc.add(NameEntered(name));
      ageEstimationBloc.add(EstimateAge());

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationLoading>(),
          isA<AgeEstimationLoaded>()
              .having((state) => state.age, 'age', isNonZero),
        ]),
      );
    });

    test('age estimation resets when reset event is added', () {
      ageEstimationBloc.add(ResetAgeEstimation());

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationInitial>(),
        ]),
      );
    });
  });
}
