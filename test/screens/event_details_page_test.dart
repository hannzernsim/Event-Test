import 'package:event_app/model/event/event.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/screens/event_details_page.dart';
import 'package:event_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';

import '../mock/clients/repo/mock_repos.dart';
import '../mock/clients/repo/mock_repos.mocks.dart';
import '../test_utils/test_utils.dart';

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

  testWidgets('EventDetailsPage is rendering correctly', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      final _event = buildEventFromTemplate();

      _mockGetEventDetailsResponse(
        response: _event,
      );

      await _pumpPage(
        tester,
        eventRestClient: _eventRestClient,
      );

      expect(find.text('Event Details'), findsOneWidget);

      expect(find.byType(Image), findsOneWidget);
      expect(find.text(_event.name), findsOneWidget);

      expect(find.byType(OutlinedButton), findsNWidgets(3));
      expect(find.text(_event.classifications[0].segment.name), findsOneWidget);
      expect(find.text(_event.classifications[0].genre.name), findsOneWidget);
      expect(find.text(_event.classifications[0].subGenre.name), findsOneWidget);

      expect(
        find.text(
          'Match Time: ${DateFormat("yyyy-MM-dd HH:mm").format(
            _event.dates.start.dateTime,
          )}',
        ),
        findsOneWidget,
      );
    });
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  EventRestClient? eventRestClient,
}) async {
  setScreenSize(tester);

  await initMockDependecies(
    eventRestClient: eventRestClient,
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  await tester.pumpWidget(
    await getTestMaterialAppBoilerplate(
      Scaffold(
        body: EventDetailsPage(
          EventDetailsPageArgs(
            id: 'EVENT-ID',
          ),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
