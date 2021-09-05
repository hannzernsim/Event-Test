part of 'event_details_cubit.dart';

abstract class EventDetailsState extends Equatable {
  final Event? event;

  const EventDetailsState({
    this.event,
  });

  @override
  List<Object?> get props => [event];
}

class EventDetailsInitial extends EventDetailsState {
  const EventDetailsInitial({
    Event? event,
  }) : super(event: event);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class EventDetailsLoadInProgress extends EventDetailsInitial {
  const EventDetailsLoadInProgress({
    Event? event,
  }) : super(event: event);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class EventDetailsLoadSuccess extends EventDetailsInitial {
  const EventDetailsLoadSuccess({
    required Event event,
  }) : super(event: event);

  @override
  List<Object?> get props => super.props..addAll([]);
}

class EventDetailsLoadFailed extends EventDetailsInitial {
  const EventDetailsLoadFailed({
    Event? event,
  }) : super(event: event);

  @override
  List<Object?> get props => super.props..addAll([]);
}
