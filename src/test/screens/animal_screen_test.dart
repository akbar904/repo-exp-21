
import 'package:flutter_test/flutter_test.dart';
import 'package:animal_switcher/screens/animal_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';
import 'package:animal_switcher/models/animal_state.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

// Mock Cubit for testing
class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalScreen Widget Tests', () {
		late AnimalCubit animalCubit;

		setUp(() {
			animalCubit = MockAnimalCubit();
		});

		testWidgets('displays Cat text and person icon initially', (WidgetTester tester) async {
			when(() => animalCubit.state).thenReturn(AnimalState('Cat', Icons.person));
			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);
		});

		testWidgets('displays Dog text and access_time icon after tap', (WidgetTester tester) async {
			whenListen(
				animalCubit,
				Stream.fromIterable([AnimalState('Cat', Icons.person), AnimalState('Dog', Icons.access_time)]),
				initialState: AnimalState('Cat', Icons.person),
			);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider.value(
						value: animalCubit,
						child: AnimalScreen(),
					),
				),
			);

			expect(find.text('Cat'), findsOneWidget);
			expect(find.byIcon(Icons.person), findsOneWidget);

			await tester.tap(find.byType(GestureDetector));
			await tester.pumpAndSettle();

			expect(find.text('Dog'), findsOneWidget);
			expect(find.byIcon(Icons.access_time), findsOneWidget);
		});
	});
}
