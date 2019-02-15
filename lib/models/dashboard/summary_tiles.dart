import 'package:flutter/material.dart';
import 'package:sterrenburg.github.flutterhole/models/app_state.dart';
import 'package:sterrenburg.github.flutterhole/models/dashboard/friendly_exception.dart';
import 'package:sterrenburg.github.flutterhole/models/dashboard/info_tile.dart';

/// A widget that shows a [List] of [InfoTile]s with statistics of the Pi-hole.
class SummaryTiles extends StatefulWidget {
  @override
  _SummaryTilesState createState() {
    return new _SummaryTilesState();
  }
}

class _SummaryTilesState extends State<SummaryTiles> {
  @override
  Widget build(BuildContext context) {
    final appState = AppState.of(context);
    return FutureBuilder<Map<String, String>>(
      future: appState.provider.fetchSummary(),
      builder: ((BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          List<Widget> infoTiles = [];
          snapshot.data.forEach((String key, String value) {
            infoTiles.add(InfoTile(
              title: key,
              value: value,
            ));
          });

          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: infoTiles,
          );
        } else if (snapshot.hasError) {
          return FriendlyException(message: snapshot.error.toString());
        }

        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
