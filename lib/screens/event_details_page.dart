import 'package:event_app/components/primary_shimmer.dart';
import 'package:event_app/cubit/event/event_details/event_details_cubit.dart';
import 'package:event_app/model/event/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_app/constants/dimens_constants.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class EventDetailsPageArgs {
  final String id;

  const EventDetailsPageArgs({required this.id});
}

class EventDetailsPage extends StatefulWidget {
  static const routeName = '/detailsScreen';

  final EventDetailsPageArgs args;

  EventDetailsPage(this.args, {Key? key}) : super(key: key);

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late EventDetailsCubit _eventDetailsCubit;

  @override
  void initState() {
    super.initState();

    _eventDetailsCubit = EventDetailsCubit.initial(
      eventId: widget.args.id,
    );
    _eventDetailsCubit.fetchEventDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: BlocBuilder<EventDetailsCubit, EventDetailsState>(
        bloc: _eventDetailsCubit,
        builder: (context, eventDetailsState) {
          final _event = eventDetailsState.event;
          final _showShimmer = eventDetailsState is EventDetailsLoadInProgress && _event == null;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final _width = constraints.maxWidth;

                  return PrimaryShimmer(
                    showShimmer: _showShimmer,
                    child: _showShimmer
                        ? SizedBox(
                            height: _width / 2,
                            width: _width,
                          )
                        : Image.network(
                            _event?.images[0].url ?? '',
                            width: _width,
                            fit: BoxFit.cover,
                          ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: xLargeSpace),
                child: PrimaryShimmer(
                  showShimmer: _showShimmer,
                  child: Text(
                    _event?.name ?? '',
                    style: TextStyle(
                      fontSize: bigFontSize,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: xLargeSpace),
                child: _Categories(
                  event: _event,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: xLargeSpace),
                child: PrimaryShimmer(
                  showShimmer: _showShimmer,
                  child: Text(
                    'Match Time: ${DateFormat("yyyy-MM-dd HH:mm").format(
                      _event?.dates.start.dateTime ?? DateTime.now(),
                    )}',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  final Event? event;

  const _Categories({
    Key? key,
    this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _data = event?.classifications.firstWhereOrNull((c) => c.primary == true);
    final _showShimmer = _data == null;

    final _shimmerList = List<Widget>.generate(
      3,
      (_) => PrimaryShimmer(
        showShimmer: _showShimmer,
        child: OutlinedButton(
          onPressed: () {},
          child: Text('hi'),
        ),
      ),
    );

    return Wrap(
      spacing: xLargeSpace,
      children: event == null
          ? _shimmerList
          : [
              PrimaryShimmer(
                showShimmer: _showShimmer,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(_data?.segment.name ?? ''),
                ),
              ),
              PrimaryShimmer(
                showShimmer: _showShimmer,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(_data?.genre.name ?? ''),
                ),
              ),
              PrimaryShimmer(
                showShimmer: _showShimmer,
                child: OutlinedButton(
                  onPressed: () {},
                  child: Text(_data?.subGenre.name ?? ''),
                ),
              ),
            ],
    );
  }
}
