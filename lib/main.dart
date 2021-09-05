import 'dart:async';

import 'package:dio/dio.dart';
import 'package:event_app/constants/key_constants.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/repo/rest_client_factory.dart';
import 'package:event_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:event_app/screens/home_page.dart';
import 'package:event_app/constants/dimens_constants.dart';
import 'package:event_app/service_locator.dart';

void main() async {
  await runZonedGuarded(
    () async {
      sl.registerLazySingleton<Dio>(() {
        final dio = Dio();

        dio.options.connectTimeout = 60000; //5s
        dio.options.receiveTimeout = 60000;

        return dio;
      });

      await _registerDependencies();

      runApp(MyApp());
    },
    (error, stack) {},
  );
}

class MyApp extends StatelessWidget {
  ElevatedButtonThemeData _getElevatedButtonTheme(ColorScheme colorScheme) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: colorScheme.primary,
        onPrimary: colorScheme.onPrimary,
      ),
    );
  }

  TextTheme _getTextTheme(ColorScheme colorScheme) {
    return TextTheme(
      bodyText2: TextStyle(
        fontSize: normalFontSize,
        color: colorScheme.onBackground,
      ),
      subtitle2: TextStyle(
        fontSize: normalFontSize,
        color: colorScheme.onBackground,
      ),
      caption: TextStyle(
        fontSize: smallFontSize,
        color: colorScheme.onBackground,
      ),
    );
  }

  ColorScheme _getColorScheme() {
    return ColorScheme(
      primary: Colors.blue,
      primaryVariant: Colors.blue.shade700,
      secondary: Colors.cyanAccent,
      secondaryVariant: Colors.cyanAccent.shade700,
      surface: Colors.white,
      background: Colors.white,
      error: Colors.red,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: Colors.black,
      onBackground: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    );
  }

  InputDecorationTheme _getInputDecorationTheme({
    required ColorScheme colorScheme,
    required TextTheme textTheme,
  }) {
    return InputDecorationTheme(
      isDense: true,
      fillColor: colorScheme.background,
      border: InputBorder.none,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.onBackground.withOpacity(0.3)),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: colorScheme.onBackground),
      ),
      contentPadding: const EdgeInsets.symmetric(
        vertical: xSmallSpace,
        horizontal: smallSpace,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _colorScheme = _getColorScheme();
    final _textTheme = _getTextTheme(_colorScheme);
    final _elevatedBtnTheme = _getElevatedButtonTheme(_colorScheme);

    return GestureDetector(
      onTap: () => WidgetsBinding.instance!.focusManager.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Event App',
        theme: ThemeData(
          scaffoldBackgroundColor: _colorScheme.background,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: _colorScheme,
          textTheme: _textTheme,
          inputDecorationTheme: _getInputDecorationTheme(
            colorScheme: _colorScheme,
            textTheme: _textTheme,
          ),
          elevatedButtonTheme: _elevatedBtnTheme,
        ),
        navigatorKey: Keys.navKey,
        onGenerateRoute: AppRouter().onGenerateRoute,
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

Future<void> _registerDependencies() async {
  sl.registerLazySingleton<EventRestClient>(
    () => RestClientFactory.getRestClient<EventRestClient>() as EventRestClient,
  );
}
