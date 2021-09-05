part of 'event_list_cubit.dart';

abstract class EventListState extends Equatable {
  final List<Event> eventList;

  const EventListState({
    required this.eventList,
  });

  @override
  List<Object?> get props => [eventList];
}

class EventListInitial extends EventListState {
  const EventListInitial({
    required List<Event> eventList,
  }) : super(eventList: eventList);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class EventListLoadInProgress extends EventListInitial {
  const EventListLoadInProgress({
    required List<Event> eventList,
  }) : super(eventList: eventList);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class EventListLoadSuccess extends EventListInitial {
  const EventListLoadSuccess({
    required List<Event> eventList,
  }) : super(eventList: eventList);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class EventListLoadFailed extends EventListInitial {
  const EventListLoadFailed({
    required List<Event> eventList,
  }) : super(eventList: eventList);

  @override
  List<Object?> get props => super.props..addAll([]);
}
