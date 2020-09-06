// this class uses for make requests
import 'package:flutter_rest_api/app/services/api.dart';
// we use 'as' in import of http for using 'http' as a seperate method for using post request in getAccessToken method 
// if you remove as the http.post is unknown in method getAccessToken method  
import 'package:http/http.dart' as http;

class APIService {
  final API api;

  APIService(this.api);

  // use this method to get the access token
  // this method return future, because making http request has imediate response from serve so we need asynchnorous
  Future<String> getAccessToken() async {
    final response = await http.post(api.tokenUri().toString(),
        headers: {'Authorization': 'Basic ${api.apiKey}'});
  }
}
