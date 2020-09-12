import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/ui/endpoit_card.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  // we need to update the state, to do that we need state variable
  int _cases;

  // loading the data from API
  Future<void> _updateData() async {
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    final cases = await dataRepository.getEndpointData(Endpoint.cases);
    setState(() => _cases = cases);
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
      body: ListView(
        children: [
          EndpointCard(
            endpoint: Endpoint.cases,
            value: _cases,
          )
        ],
      ),
    );
  }
}
