import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/constants/key_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_app/model/event/event.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/repo/rest_client_factory.dart';
import 'package:event_app/service_locator.dart';

part 'event_details_state.dart';

class EventDetailsCubit extends Cubit<EventDetailsState> {
  final EventRestClient _eventRestClient;
  final String _eventId;

  EventDetailsCubit({
    required String eventId,
    EventDetailsState? state,
  })  : _eventRestClient = sl.get<EventRestClient>(),
        _eventId = eventId,
        super(EventDetailsInitial());

  factory EventDetailsCubit.initial({
    required String eventId,
    EventDetailsState? state,
  }) {
    if (sl.isRegistered<EventDetailsCubit>()) {
      return sl.get<EventDetailsCubit>();
    }

    return EventDetailsCubit(
      eventId: eventId,
      state: state,
    );
  }

  Future<void> fetchEventDetails() async {
    emit(EventDetailsLoadInProgress(event: state.event));

    await apiCaller(() async {
      final response = await _eventRestClient.getEventDetails(
        Keys.apiKey,
        _eventId,
      );

      emit(EventDetailsLoadSuccess(event: response));
    }, onError: (e) {
      emit(EventDetailsLoadFailed(event: state.event));
    });
  }
}
