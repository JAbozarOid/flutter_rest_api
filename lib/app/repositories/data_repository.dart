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
}
