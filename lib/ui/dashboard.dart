import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/ui/endpoit_card.dart';
import 'package:flutter_rest_api/ui/last_updated_status_text.dart';
import 'package:flutter_rest_api/ui/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // we need to update the state, to do that we need state variable
  EndpointsData _endpointData;

  // loading the data from API
  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointData = await dataRepository.getAllEndpointData();
      setState(() => _endpointData = endpointData);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Connection Error',
          content: 'Could not retrive data. Please try again later',
          defaultActionText: 'ok');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Unknown Error',
          content: 'Please contact support or try again later',
          defaultActionText: 'ok');
    }
  }

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointData = dataRepository.getAllEndpointsCachedData();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedDateFormatter(
        lastUpdated: _endpointData != null
            ? _endpointData.values[Endpoint.cases]?.date
            : null);
    // with ?. after statement _endpointData.values[Endpoint.cases] we check if the statement is not null get the value of date variable
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: RefreshIndicator(
        // onRefresh callBack get the method with the future type of "void"
        // RefreshIndicator is great when calling REST APIs to refresh data from the server
        onRefresh: _updateData,
        child: ListView(
          children: [
            // ? maybe the date is null and ? operation handle it
            // ?? if date.toString was null return ''
            // show the last update from server
            LastUpdatedStatusText(text: formatter.lastUpdatedStatusText()
                /* _endpointData != null
                    ? _endpointData.values[Endpoint.cases].date?.toString() ??
                        ''
                    : '' */
                ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointData != null
                    ? _endpointData.values[endpoint]?.value
                    : null,
              )
          ],
        ),
      ),
    );
  }
}
