import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api.dart';

// create a model class we can use to group together all the data
class EndpointData {
  // rather than use like below lines we can use map of endpoint and int
  //final int cases;
  //final int casesSuspected;
  //final int casesConfirmed;
  //final int deaths;
  //final int recovered;

  final Map<Endpoint, int> values;

  EndpointData({@required this.values});

  // makes EndpointsData easier to query
  int get cases => values[Endpoint.cases];
  int get casesSuspected => values[Endpoint.casesSuspected];
  int get casesConfirmed => values[Endpoint.casesConfirmed];
  int get deaths => values[Endpoint.deaths];
  int get recovered => values[Endpoint.recovered];

  // for print the debugging information for giving endpoint data object
  @override
  String toString() =>
      'cases: $cases, suspected: $casesSuspected, confirmed: $casesConfirmed, deaths: $deaths, recovered: $recovered';
}
