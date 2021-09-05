import 'package:event_app/model/event/date_info.dart';
import 'package:event_app/model/event/dates.dart';
import 'package:event_app/model/event/event.dart';
import 'package:event_app/model/event/event_details/classifications/classification_details.dart';
import 'package:event_app/model/event/event_details/classifications/classification_obj.dart';
import 'package:event_app/model/event/event_details/sales/sales.dart';
import 'package:event_app/model/event/event_details/sales/sales_details.dart';
import 'package:event_app/model/event/event_list.dart';
import 'package:event_app/model/event/event_list_response.dart';
import 'package:event_app/model/event/image_data.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([EventRestClient])
void main() {}

EventListResponse buildGetEventListResponseFromTemplate({
  required List<Event> eventList,
}) {
  return EventListResponse(
    embedded: EventList(
      events: eventList,
    ),
  );
}

Event buildEventFromTemplate({
  String id = 'event_id',
  String name = 'event_name',
  List<ImageData>? images,
  DateTime? dateTime,
  SalesDetails? salesDetails,
  ClassificationObj? classificationObj,
}) {
  return Event(
    id: id,
    name: name,
    images: images ?? [ImageData(url: 'http://thisistheimageurl.com')],
    dates: Dates(
      start: DateInfo(
        dateTime: dateTime ?? DateTime(2021, 3, 9, 8, 56, 23),
      ),
    ),
    sales: Sales(
      details: salesDetails ??
          SalesDetails(
            startDateTime: DateTime(2021, 3, 9, 8, 56, 23),
            endDateTime: DateTime(2021, 3, 9, 8, 56, 23),
          ),
    ),
    classifications: [
      classificationObj ??
          ClassificationObj(
            primary: true,
            segment: ClassificationDetails(
              id: 'segment',
              name: 'segment',
            ),
            genre: ClassificationDetails(
              id: 'genre',
              name: 'genre',
            ),
            subGenre: ClassificationDetails(
              id: 'subGenre',
              name: 'subGenre',
            ),
          ),
    ],
  );
}
