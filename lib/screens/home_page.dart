import 'package:event_app/components/primary_shimmer.dart';
import 'package:event_app/cubit/event/event_list_cubit.dart';
import 'package:event_app/model/event/event.dart';
import 'package:event_app/screens/event_details_page.dart';
import 'package:event_app/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:event_app/constants/dimens_constants.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/homeScreen';

  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late EventListCubit _eventListCubit;

  @override
  void initState() {
    super.initState();

    _eventListCubit = EventListCubit.initial();
    _eventListCubit.fetchEventList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event App'),
      ),
      body: BlocBuilder<EventListCubit, EventListState>(
        bloc: _eventListCubit,
        builder: (context, eventListState) {
          final list = eventListState.eventList;
          final _showShimmer = eventListState is EventListLoadInProgress && list.isEmpty;

          return RefreshIndicator(
              onRefresh: () => _eventListCubit.fetchEventList(),
              child: ListView.separated(
                physics: _showShimmer ? NeverScrollableScrollPhysics() : null,
                itemCount: _showShimmer ? 20 : list.length,
                itemBuilder: (context, index) {
                  return _EventItem(
                    event: _showShimmer ? null : list[index],
                    showShimmer: _showShimmer,
                  );
                },
                separatorBuilder: (context, index) => Divider(),
              ));
        },
      ),
    );
  }
}

class _EventItem extends StatelessWidget {
  final Event? event;
  final bool showShimmer;

  const _EventItem({
    Key? key,
    this.event,
    required this.showShimmer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!showShimmer && event != null) {
          pushNamed(
            EventDetailsPage.routeName,
            arguments: EventDetailsPageArgs(id: event!.id),
          );
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: xSmallSpace),
        child: ListTile(
          leading: PrimaryShimmer(
            showShimmer: showShimmer,
            child: showShimmer
                ? SizedBox(
                    height: eventIconWidth,
                    width: eventIconWidth,
                  )
                : Image.network(
                    event?.images[0].url ?? '',
                    width: eventIconWidth,
                    fit: BoxFit.cover,
                  ),
          ),
          title: PrimaryShimmer(
            showShimmer: showShimmer,
            child: Text(event?.name ?? ''),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: smallSpace),
            child: PrimaryShimmer(
              showShimmer: showShimmer,
              child: Text(
                DateFormat("yyyy-MM-dd HH:mm").format(
                  event?.dates.start.dateTime ?? DateTime.now(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
