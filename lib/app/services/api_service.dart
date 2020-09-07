// this class uses for make requests
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api.dart';
// we use 'as' in import of http for using 'http' as a seperate method for using post request in getAccessToken method
// if you remove as the http.post is unknown in method getAccessToken method
import 'package:http/http.dart' as http;

// use this class for making requests
class APIService {
  final API api;

  APIService(this.api);

  // use this method to get the access token
  // this method return future, because making http request has imediate response from serve so we need asynchnorous
  Future<String> getAccessToken() async {
    final response = await http.post(api.tokenUri().toString(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});
    if (response.statusCode == 200) {
      // because of the response in json format we must decode the json body (get String object)
      // decode method parse the json in input string and return a key value pairs
      final data = json.decode(response.body);
      final accessToken = data['access_token'];
      if (accessToken != null) {
        return accessToken;
      }
    }

    print(
        'Request ${api.tokenUri()} failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    // if there was an error it must be handled in presentation and UI layer
    throw response;
  }

  Future<int> getEndpointData(
      {@required String accessToken, @required Endpoint endpoint}) async {
    final uri = api.endpointUri(endpoint);
    final response = await http
        .get(uri.toString(), headers: {'Authorization': 'Bearer $accessToken'});

    if (response.statusCode == 200) {
      // parse response
      // the response json is list
      final List<dynamic> data = json.decode(response.body);
      if (data.isNotEmpty) {
        final Map<String, dynamic> endpointData = data[0];
        final String responseJsonKey = _responseJsonKeys[endpoint];
        final int result = endpointData[responseJsonKey];
        if(result != null) {
          return result;
        }
      }
    }
     print(
        'Request $uri failed\nResponse: ${response.statusCode} ${response.reasonPhrase}');
    throw response;
  }

  // create a map that associate each endpoints to the json key that we will use to extract the data
  // except cases other endpoint have same response format
  static Map<Endpoint, String> _responseJsonKeys = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'data',
    Endpoint.casesConfirmed: 'data',
    Endpoint.deaths: 'data',
    Endpoint.recovered: 'data',
  };
}
