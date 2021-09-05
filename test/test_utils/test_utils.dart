import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:event_app/constants/key_constants.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/service_locator.dart';
import 'package:event_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/clients/repo/mock_repos.mocks.dart';

Future<void> initMockDependecies({
  EventRestClient? eventRestClient,
}) async {
  sl.registerLazySingleton<EventRestClient>(() => eventRestClient ?? MockEventRestClient());
}

/// Make sure to call sl.reset() before calling this function to reset any registered types
Future<Widget> getTestMaterialAppBoilerplate(
  Widget widgetToTest, {
  bool enableI18nMocking = true,
  NavigatorObserver? navObserver,
}) async {
  return TestApp(
    widgetToTest: widgetToTest,
    navObserver: navObserver,
  );
}

class TestApp extends StatefulWidget {
  final NavigatorObserver? navObserver;
  final Widget widgetToTest;

  const TestApp({
    Key? key,
    required this.widgetToTest,
    this.navObserver,
  }) : super(key: key);

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  late AppRouter _appRouter;

  @override
  void initState() {
    super.initState();

    _appRouter = AppRouter();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);

        // This is a neat trick to enable dismissing of the keyboard
        // by tapping outside
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Event App',
        navigatorKey: Keys.navKey,
        navigatorObservers: [
          if (widget.navObserver != null) widget.navObserver!,
        ],
        onGenerateRoute: _appRouter.onGenerateRoute,
        home: widget.widgetToTest,
      ),
    );
  }
}

class TestObj extends Equatable {
  final String title, desc;

  const TestObj(this.title, this.desc);

  @override
  String toString() {
    return 'Title: $title';
  }

  @override
  List<Object> get props => [title, desc];
}

/// Use this to set a custom testing screen size
void setScreenSize(WidgetTester tester, {double width = 1440.0, double height = 3040.0}) {
  tester.binding.window.textScaleFactorTestValue = 0.5;
  tester.binding.window.physicalSizeTestValue = Size(width, height);
  addTearDown(tester.binding.window.clearPhysicalSizeTestValue);
}
