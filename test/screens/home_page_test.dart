import 'package:event_app/model/event/event_list_response.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:event_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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

  void _mockGetEventListResponse({EventListResponse? response, dynamic exception}) {
    if (response != null) {
      when(_eventRestClient.getEventList(any)).thenAnswer(
        (_) => Future.value(response),
      );
    } else if (exception != null) {
      when(_eventRestClient.getEventList(any)).thenThrow(exception);
    }
  }

  testWidgets('HomePage is rendering correctly', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      final _eventList = [
        buildEventFromTemplate(name: 'event1'),
        buildEventFromTemplate(name: 'event2'),
        buildEventFromTemplate(name: 'event3'),
      ];

      _mockGetEventListResponse(
        response: buildGetEventListResponseFromTemplate(
          eventList: _eventList,
        ),
      );

      await _pumpPage(
        tester,
        eventRestClient: _eventRestClient,
      );

      expect(find.text('Event App'), findsOneWidget);

      expect(find.byType(ListTile), findsNWidgets(_eventList.length));
      expect(find.byType(Image), findsNWidgets(_eventList.length));

      expect(find.text('event1'), findsOneWidget);
      expect(find.text('event2'), findsOneWidget);
      expect(find.text('event3'), findsOneWidget);
    });
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  EventRestClient? eventRestClient,
}) async {
  await initMockDependecies(
    eventRestClient: eventRestClient,
  );

  TestWidgetsFlutterBinding.ensureInitialized();

  await tester.pumpWidget(
    await getTestMaterialAppBoilerplate(
      Scaffold(
        body: HomePage(),
      ),
    ),
  );
  await tester.pump();
}
