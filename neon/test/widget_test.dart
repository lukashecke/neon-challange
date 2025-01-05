import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neon/feature/age_estimation/bloc/age_estimation_bloc.dart';
import 'package:neon/feature/age_estimation/data/age_estimation_repository.dart';
import 'package:neon/feature/age_estimation/model/age_estimation.dart';
import 'package:neon/main.dart';

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

  group('AgeEstimationPage (User Story 2)', () {
    late AgeEstimationRepository ageEstimationRepository;

    setUp(() {
      ageEstimationRepository = MockRepository();
      when(() => ageEstimationRepository.fetchNameEstimation(any())).thenAnswer(
        (_) async => AgeEstimation(name: 'Test', age: 42, count: 1),
      );
    });

    testWidgets('Button does nothing initially', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNull,
      );
    });

    testWidgets('Button activates when TextField is not empty',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await _enterTextToTextField(tester, 'Test');

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNotNull,
      );
    });

    testWidgets('Button deactivates after search', (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await _enterTextToTextField(tester, 'Test');

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNotNull,
      );

      await _tapSearchButton(tester);

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNull,
      );
    });

    testWidgets('Button reactivates after searching a new name',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await _enterTextToTextField(tester, 'Test');

      await _tapSearchButton(tester);

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNull,
      );

      await _enterTextToTextField(tester, 'Test2');

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNotNull,
      );
    });

    testWidgets(
        'Button deactivates after searching the same name twice in a row',
        (WidgetTester tester) async {
      await tester.pumpWidget(const MyApp());

      await _enterTextToTextField(tester, 'Test');

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNotNull,
      );

      await _tapSearchButton(tester);

      await _enterTextToTextField(tester, '');

      await _enterTextToTextField(tester, 'Test');

      expect(
        tester.widget<FloatingActionButton>(buttonFinder).onPressed,
        isNull,
      );
    });
  });
}

final buttonFinder = find.widgetWithIcon(
  FloatingActionButton,
  Icons.search,
);

Future<void> _enterTextToTextField(WidgetTester tester, String text) async {
  final textFieldFinder = find.byType(TextField);

  await tester.enterText(textFieldFinder, text);
  await tester.testTextInput.receiveAction(TextInputAction.done);
  await tester.pump();
}

Future<void> _tapSearchButton(WidgetTester tester) async {
  await tester.tap(find.byIcon(Icons.search));
  await tester.pump();
}
