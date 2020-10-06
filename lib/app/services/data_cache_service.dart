import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/repositories/endpoints_data.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/app/services/endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

// our goal for this class is -> write all code for writing and reading data with Shared Preferences
class DataCacheService {
  final SharedPreferences sharedPreferences;

  DataCacheService({@required this.sharedPreferences});

  // saving data to Shared Preferences
  // saving data with Shared Preferences is an async operation
  // shared preferences is a key value code
  Future<void> setData(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      // saving in shared preferences will be valid for some general data types like int,double and ....
      // so EndpointData class is a  custom class that has two variables that include int value and DateTime date -> so we need to write some serialization code
      // so for to do that we user endpointValueKey method
      await sharedPreferences.setInt(
          endpointValueKey(endpoint), endpointData.value);
      await sharedPreferences.setString(
          endpointDataKey(endpoint), endpointData.date.toIso8601String());
      // toIso8601String it is a standard format to convert date as string
    });
  }

  // read data from shared preferences
  EndpointsData getData() {
    Map<Endpoint, EndpointData> values = {};
    Endpoint.values.forEach((endpoint) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDataKey(endpoint));
      if (value != null && dateString != null) {
        final date = DateTime.tryParse(dateString);
        values[endpoint] = EndpointData(value: value, date: date);
      }
    });
    return EndpointsData(values: values);
  }

  // EndpointData class has two parameters that include int value and DateTime date
  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';
  static String endpointDataKey(Endpoint endpoint) => '$endpoint/data';
}
