import 'package:dio/dio.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/service_locator.dart';

abstract class RestClient {}

class RestClientFactory {
  static RestClient getRestClient<T>() {
    final dio = sl.get<Dio>();

    return EventRestClient(dio);
  }
}

Future<void> apiCaller(
  Function() body, {
  required Function(Exception error) onError,
}) async {
  try {
    await body();
  } catch (e) {
    onError(e as Exception);
  }
}
