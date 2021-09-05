import 'package:event_app/cubit/event/event_list_cubit.dart';
import 'package:event_app/model/event/event_list_response.dart';
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

  void _mockGetEventListResponse({EventListResponse? response, dynamic exception}) {
    if (response != null) {
      when(_eventRestClient.getEventList(any)).thenAnswer(
        (_) => Future.value(response),
      );
    } else if (exception != null) {
      when(_eventRestClient.getEventList(any)).thenThrow(exception);
    }
  }

  test('EventListCubit init with EventListInitial', () async {
    final _eventListCubit = await _getEventListCubit();

    expect(_eventListCubit.state, equals(isA<EventListInitial>()));
  });

  group('fetchEventList', () {
    test('fetchEventList should change state to EventListLoadFailed if failed', () async {
      _mockGetEventListResponse(exception: Exception());

      final _eventListCubit = await _getEventListCubit(
        eventRestClient: _eventRestClient,
      );

      await _eventListCubit.fetchEventList();

      expect(_eventListCubit.state, equals(isA<EventListLoadFailed>()));
    });

    test('fetchEventList should change state to EventListLoadSuccess if successful', () async {
      _mockGetEventListResponse(
        response: buildGetEventListResponseFromTemplate(
          eventList: [
            buildEventFromTemplate(),
            buildEventFromTemplate(),
            buildEventFromTemplate(),
          ],
        ),
      );

      final _eventListCubit = await _getEventListCubit(
        eventRestClient: _eventRestClient,
      );

      await _eventListCubit.fetchEventList();

      expect(_eventListCubit.state, equals(isA<EventListLoadSuccess>()));
    });
  });
}

Future<EventListCubit> _getEventListCubit({
  EventRestClient? eventRestClient,
}) async {
  await initMockDependecies(
    eventRestClient: eventRestClient,
  );

  final _eventListCubit = EventListCubit();

  return _eventListCubit;
}
