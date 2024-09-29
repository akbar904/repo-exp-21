
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/main.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('Main App', () {
		testWidgets('initializes the app and displays AnimalScreen', (WidgetTester tester) async {
			await tester.pumpWidget(MyApp());
			expect(find.byType(MaterialApp), findsOneWidget);
			expect(find.byType(AnimalScreen), findsOneWidget);
		});
	});

	group('AnimalCubit', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		test('initial state is AnimalState with Cat and person icon', () {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.person));
			expect(animalCubit.state.animal, equals('Cat'));
			expect(animalCubit.state.icon, equals(Icons.person));
		});

		blocTest<AnimalCubit, AnimalState>(
			'emits Dog with access_time icon when toggleAnimal is called',
			build: () => animalCubit,
			act: (cubit) {
				when(() => cubit.state).thenReturn(AnimalState('Dog', Icons.access_time));
				cubit.toggleAnimal();
			},
			expect: () => [AnimalState('Dog', Icons.access_time)],
		);
	});

	group('AnimalScreen', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.person));
		});

		testWidgets('displays initial animal state', (WidgetTester tester) async {
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (context) => animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('toggles to Dog when tapped', (WidgetTester tester) async {
			when(() => animalCubit.toggleAnimal()).thenAnswer((_) {
				when(() => animalCubit.state).thenReturn(AnimalState('Dog', Icons.access_time));
			});

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AnimalCubit>(
						create: (context) => animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			await tester.tap(find.byType(InkWell));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});
}
