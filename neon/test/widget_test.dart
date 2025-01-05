import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';
import 'package:neon/feature/age_estimation/data/age_estimation_repository.dart';
import 'package:neon/feature/age_estimation/model/age_estimation.dart';

class MockRepository extends Mock implements AgeEstimationRepository {}

void main() {
  group('AgeEstimationBloc (User Story 1)', () {
    late AgeEstimationBloc ageEstimationBloc;
    late AgeEstimationRepository ageEstimationRepository;

    setUp(() {
      ageEstimationRepository = MockRepository();
      ageEstimationBloc =
          AgeEstimationBloc(repository: ageEstimationRepository);
      when(() => ageEstimationRepository.fetchNameEstimation(any())).thenAnswer(
        (_) async => AgeEstimation(name: 'Test', age: 42, count: 1),
      );
    });

    test('initial state is AgeEstimationInitial', () {
      expect(ageEstimationBloc.state, isA<AgeEstimationInitial>());
    });

    test('age estimation is shown when name is entered and button is pressed',
        () {
      const name = 'John Doe';
      ageEstimationBloc.add(NameEntered(name));

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
      const name = '';
      ageEstimationBloc.add(NameEntered(name));

      expectLater(
        ageEstimationBloc.stream,
        emitsInOrder([
          isA<AgeEstimationError>(),
        ]),
      );
    });
  });
}
