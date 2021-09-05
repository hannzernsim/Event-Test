import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:event_app/constants/key_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_app/model/event/event.dart';
import 'package:event_app/repo/event_rest_client.dart';
import 'package:event_app/repo/rest_client_factory.dart';
import 'package:event_app/service_locator.dart';

part 'event_list_state.dart';

class EventListCubit extends Cubit<EventListState> {
  final EventRestClient _eventRestClient;

  EventListCubit()
      : _eventRestClient = sl.get<EventRestClient>(),
        super(EventListInitial(eventList: []));

  factory EventListCubit.initial({EventListState? state}) {
    if (sl.isRegistered<EventListCubit>()) {
      return sl.get<EventListCubit>();
    }

    return EventListCubit();
  }

  Future<void> fetchEventList() async {
    emit(EventListLoadInProgress(eventList: state.eventList));

    await apiCaller(() async {
      final response = await _eventRestClient.getEventList(Keys.apiKey);

      emit(EventListLoadSuccess(eventList: response.embedded.events));
    }, onError: (e) {
      emit(EventListLoadFailed(eventList: state.eventList));
    });
  }
}
