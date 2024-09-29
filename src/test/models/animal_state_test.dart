
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:animal_switcher/models/animal_state.dart';

void main() {
	group('AnimalState', () {
		test('should correctly instantiate with given animal and icon', () {
			const animal = 'Cat';
			const icon = Icons.person;

			final state = AnimalState(animal, icon);

			expect(state.animal, animal);
			expect(state.icon, icon);
		});

		test('should support value equality', () {
			const animal = 'Cat';
			const icon = Icons.person;

			final state1 = AnimalState(animal, icon);
			final state2 = AnimalState(animal, icon);

			expect(state1, equals(state2));
		});

		test('should have correct props', () {
			const animal = 'Cat';
			const icon = Icons.person;

			final state = AnimalState(animal, icon);

			expect(state.props, [animal, icon]);
		});
	});
}
