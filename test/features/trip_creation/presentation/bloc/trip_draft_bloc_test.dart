import 'package:flutter_test/flutter_test.dart';
import 'package:hamsafar/features/trip_creation/presentation/bloc/trip_draft_bloc.dart';

void main() {
  group('TripDraftBloc', () {
    test('updates a draft in response to typed events', () async {
      final bloc = TripDraftBloc();
      addTearDown(bloc.close);

      final emitted = expectLater(
        bloc.stream,
        emitsThrough(
          predicate((state) => state.name == 'Weekend trip'),
        ),
      );

      bloc.add(const TripNameChanged('Weekend trip'));

      await emitted;
      expect(bloc.state.name, 'Weekend trip');
    });

    test('trims and ignores empty cost items', () async {
      final bloc = TripDraftBloc();
      addTearDown(bloc.close);

      final emitted = expectLater(
        bloc.stream,
        emitsThrough(
          predicate((state) => state.costItems.contains('transport')),
        ),
      );

      bloc.add(const TripCostItemAdded('  transport  '));
      await emitted;

      final previousItems = List<String>.of(bloc.state.costItems);
      bloc.add(const TripCostItemAdded('  '));
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state.costItems, previousItems);
    });

    test('ignores out-of-range departure option updates', () async {
      final bloc = TripDraftBloc();
      addTearDown(bloc.close);

      final before = bloc.state.departureOptions;
      bloc.add(
        TripDepartureOptionRemoved(before.length + 1),
      );
      await Future<void>.delayed(Duration.zero);

      expect(bloc.state.departureOptions, before);
    });
  });
}
