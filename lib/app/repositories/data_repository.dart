import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/app/services/api_service.dart';
import 'package:http/http.dart';

class DataRepository {
  final APIService apiService;

  // save the token as a state variable
  String _accessToken;

  DataRepository({@required this.apiService});

  // use this method to get data for giving endpoint
  Future<int> getEndpointData(Endpoint endpoint) async {
    try {
      if (_accessToken == null) {
        _accessToken = await apiService.getAccessToken();
      }
      return await apiService.getEndpointData(
          accessToken: _accessToken, endpoint: endpoint);
    } on Response catch (response) {
      // if unauthorized, get access token again -> 401
      if (response.statusCode == 401) {
        _accessToken = await apiService.getAccessToken();
        return await apiService.getEndpointData(
            accessToken: _accessToken, endpoint: endpoint);
      }
      // if there is another error we just throw it
      rethrow;
    }
  }

  // we must refresh the access token when it has beed expired

  // the benefit of the using a method that refresh the data at once
  // update data from multiple endpoints
  // first step is how to combine together the responses from the multiple API endpoint
  Future<void> _getAllEndpointsData() async {
    // this method get list of futures as input arguments and return a single future
    // Future.wait() -> all futures execute in parallel(concurrently) -> when all futures have completed, result is returned
    await Future.wait([
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.cases),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesSuspected),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.casesConfirmed),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.deaths),
      apiService.getEndpointData(
          accessToken: _accessToken, endpoint: Endpoint.recovered),
    ]);
  }
}
