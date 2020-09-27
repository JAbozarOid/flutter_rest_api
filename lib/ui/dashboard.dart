import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/ui/endpoit_card.dart';
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
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final endpointData = await dataRepository.getAllEndpointData();
    setState(() => _endpointData = endpointData);
  }

  @override
  void initState() {
    super.initState();
    _updateData();
  }

  @override
  Widget build(BuildContext context) {
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
            for(var endpoint in Endpoint.values)
            EndpointCard(
              endpoint: endpoint,
              value: _endpointData != null ? _endpointData.values[endpoint].value : null,
            )
          ],
        ),
      ),
    );
  }
}
