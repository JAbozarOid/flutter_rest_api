// this class uses for make requests
import 'dart:convert';

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
}
