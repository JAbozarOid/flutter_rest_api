import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api_keys.dart';

class API {
  final String apiKey;

  // constructor for this class
  API({@required this.apiKey});

  // a factory constructor which will be a little helper that we will use when we created instances of this class
  // this factory constructor will return an API object using sanbox key in the APIKeys class
  factory API.sanbox() => API(apiKey: APIKeys.ncovSandboxKey);

  //initialize a static variable
  static final String host = 'ncov2019-admin.firebaseapp.com';

  // uri class provides functions to encode and decode strings for use in URLS  
  // Api Service class will be responsible for converting this uri to string
  Uri tokenUri() => Uri(
    scheme: 'https',
    host: host,
    path: 'token',
  );
}
