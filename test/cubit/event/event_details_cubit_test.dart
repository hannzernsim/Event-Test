import 'package:event_app/cubit/event/event_details/event_details_cubit.dart';
import 'package:event_app/model/event/event.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_app/service_locator.dart';
import 'package:mockito/mockito.dart';

import '../../mock/clients/repo/mock_repos.dart';
import '../../mock/clients/repo/mock_repos.mocks.dart';
import '../../test_utils/test_utils.dart';

void main() {
  late MockEventRestClient _eventRestClient;

  setUp(() async {
    await sl.reset();

    _eventRestClient = MockEventRestClient();
  });

  void _mockGetEventDetailsResponse({Event? response, dynamic exception}) {
    if (response != null) {
      when(_eventRestClient.getEventDetails(any, any)).thenAnswer(
        (_) => Future.value(response),
      );
    } else if (exception != null) {
      when(_eventRestClient.getEventDetails(any, any)).thenThrow(exception);
    }
  }

  test('EventDetailsCubit init with EventDetailsInitial', () async {
    final _eventDetailsCubit = await _getEventDetailsCubit();

    expect(_eventDetailsCubit.state, equals(isA<EventDetailsInitial>()));
  });

  group('fetchEventDetails', () {
    test('fetchEventDetails should change state to EventDetailsLoadFailed if failed', () async {
      _mockGetEventDetailsResponse(exception: Exception());

      final _eventDetailsCubit = await _getEventDetailsCubit(
        eventRestClient: _eventRestClient,
      );

      await _eventDetailsCubit.fetchEventDetails();

      expect(_eventDetailsCubit.state, equals(isA<EventDetailsLoadFailed>()));
    });

    test('fetchEventDetails should change state to EventDetailsLoadSuccess if successful', () async {
      final _eventDetails = buildEventFromTemplate();

      _mockGetEventDetailsResponse(
        response: _eventDetails,
      );

      final _eventDetailsCubit = await _getEventDetailsCubit(
        eventRestClient: _eventRestClient,
      );

      await _eventDetailsCubit.fetchEventDetails();

      expect(_eventDetailsCubit.state, equals(isA<EventDetailsLoadSuccess>()));
      expect(_eventDetailsCubit.state.event, equals(_eventDetails));
    });
  });
}

Future<EventDetailsCubit> _getEventDetailsCubit({
  EventRestClient? eventRestClient,
}) async {
  await initMockDependecies(
    eventRestClient: eventRestClient,
  );

  final _eventDetailsCubit = EventDetailsCubit.initial(eventId: 'EVENT-ID');

  return _eventDetailsCubit;
}
