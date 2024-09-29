
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:animal_switcher/cubits/animal_cubit.dart';

class MockAnimalCubit extends MockCubit<AnimalState> implements AnimalCubit {}

void main() {
	group('AnimalCubit', () {
		blocTest<AnimalCubit, AnimalState>(
			'emits Cat state initially and Dog state after toggle',
			build: () => AnimalCubit(),
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				AnimalState('Cat', Icons.person),
				AnimalState('Dog', Icons.access_time),
			],
		);

		blocTest<AnimalCubit, AnimalState>(
			'emits Dog state initially and Cat state after toggle',
			build: () {
				final cubit = AnimalCubit();
				cubit.toggleAnimal(); // Initial toggle to Dog state
				return cubit;
			},
			act: (cubit) => cubit.toggleAnimal(),
			expect: () => [
				AnimalState('Dog', Icons.access_time),
				AnimalState('Cat', Icons.person),
			],
		);
	});
}
