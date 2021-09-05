import 'package:event_app/components/primary_shimmer.dart';
import 'package:event_app/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart';
import 'package:shimmer/shimmer.dart';

import '../test_utils/test_utils.dart';

void main() {
  setUp(() async {
    await sl.reset();
  });

  void _showSnackBarWithText(BuildContext context, String message) {
    //dismiss current snackbar first before showing another
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  testWidgets('PrimaryShimmer is render without shimmer', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await _pumpPage(tester, child: Text('test'), showShimmer: false);

      expect(find.text('test'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Shimmer), findsNothing);
    });
  });

  testWidgets('PrimaryShimmer is render with shimmer but not wrap with background container',
      (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await _pumpPage(tester, child: Text('test'), showShimmer: true, wrapWithBackground: false);

      expect(find.text('test'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Shimmer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });
  });

  testWidgets('PrimaryShimmer is render with shimmer and wrap with background container', (WidgetTester tester) async {
    await mockNetworkImages(() async {
      await _pumpPage(tester, child: Text('test'), showShimmer: true, wrapWithBackground: true);

      expect(find.text('test'), findsOneWidget);
      expect(find.byType(Text), findsOneWidget);
      expect(find.byType(Shimmer), findsOneWidget);
      expect(find.byType(Container), findsWidgets);
    });
  });

  group('Tapping event', () {
    testWidgets('PrimaryShimmer is ignore tap event if shimmer is showing', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await _pumpPage(
          tester,
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  _showSnackBarWithText(context, 'hi snackbar.');
                },
                child: Text('test'),
              );
            },
          ),
          showShimmer: true,
        );

        await tester.tap(find.byType(TextButton), warnIfMissed: false);
        await tester.pump();

        expect(find.text('hi snackbar.'), findsNothing);
      });
    });

    testWidgets('PrimaryShimmer is trigger tap event correctly', (WidgetTester tester) async {
      await mockNetworkImages(() async {
        await _pumpPage(
          tester,
          child: Builder(
            builder: (context) {
              return TextButton(
                onPressed: () {
                  _showSnackBarWithText(context, 'hi snackbar.');
                },
                child: Text('test'),
              );
            },
          ),
          showShimmer: false,
        );

        await tester.tap(find.byType(TextButton), warnIfMissed: false);
        await tester.pump();

        expect(find.text('hi snackbar.'), findsOneWidget);
      });
    });
  });
}

Future<void> _pumpPage(
  WidgetTester tester, {
  bool wrapWithBackground = true,
  bool showShimmer = true,
  required Widget child,
}) async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await tester.pumpWidget(
    await getTestMaterialAppBoilerplate(
      Scaffold(
        body: PrimaryShimmer(
          showShimmer: showShimmer,
          wrapWithBackground: wrapWithBackground,
          child: child,
        ),
      ),
    ),
  );
  await tester.pump();
}
