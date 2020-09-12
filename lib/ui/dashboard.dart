import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/ui/endpoit_card.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coronavirus Tracker'),
      ),
      body: ListView(
        children: [EndpointCard(endpoint: Endpoint.cases,value: 123,)],
      ),
    );
  }
}
