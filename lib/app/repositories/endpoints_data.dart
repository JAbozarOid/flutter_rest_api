import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/app/services/endpoint_data.dart';

// create a model class we can use to group together all the data
class EndpointsData {
  // rather than use like below lines we can use map of endpoint and int
  //final int cases;
  //final int casesSuspected;
  //final int casesConfirmed;
  //final int deaths;
  //final int recovered;

  final Map<Endpoint, EndpointData> values;

  EndpointsData({@required this.values});

  // makes EndpointsData easier to query
  EndpointData get cases => values[Endpoint.cases];
  EndpointData get casesSuspected => values[Endpoint.casesSuspected];
  EndpointData get casesConfirmed => values[Endpoint.casesConfirmed];
  EndpointData get deaths => values[Endpoint.deaths];
  EndpointData get recovered => values[Endpoint.recovered];

  // for print the debugging information for giving endpoint data object
  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
