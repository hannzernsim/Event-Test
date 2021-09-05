import 'package:event_app/model/event/event.dart';
import 'package:event_app/model/event/event_list_response.dart';
import 'package:event_app/repo/rest_client_factory.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'event_rest_client.g.dart';

@RestApi(baseUrl: "https://app.ticketmaster.com/discovery/v2")
abstract class EventRestClient extends RestClient {
  factory EventRestClient(Dio dio, {String baseUrl}) = _EventRestClient;

  @GET('/events.json')
  Future<EventListResponse> getEventList(
    @Query('apikey') String apiKey,
  );

  @GET('/events/{id}.json')
  Future<Event> getEventDetails(
    @Query('apikey') String apiKey,
    @Path('id') String id,
  );
}
