import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api_keys.dart';

// create an enum for all different endpoints
enum Endpoint {
  cases,
  casesSuspected,
  casesConfirmed,
  deaths,
  recovered,
}

// this class uses for list of all endpoints
class API {
  final String apiKey;

  // constructor for this class
  API({@required this.apiKey});

  // a factory constructor which will be a little helper that we will use when we created instances of this class
  // this factory constructor will return an API object using sanbox key in the APIKeys class
  factory API.sanbox() => API(apiKey: APIKeys.ncovSandboxKey);

  // *** initialize a static variable
  static final String host = 'ncov2019-admin.firebaseapp.com';
  
  //static final String host = 'apigw.nubentos.com';
  //static final int port = 443;
  //static final String basePath = 't/nubentos.com/ncovapi/1.0.0';

  // uri class provides functions to encode and decode strings for use in URLS
  // Api Service class will be responsible for converting this uri to string
  Uri tokenUri() => Uri(
        scheme: 'https',
        host: host,
        //port: port,
        path: 'token',
        //queryParameters: {'grant_type': 'client_credentials'},
      );

  Uri endpointUri(Endpoint endpoint) => Uri(
      scheme: 'https',
      host: host,
      //port: port,
      //path: '$basePath/${_path[endpoint]}'
      path: _path[endpoint]
      );

  // create a map we will be associate each endpoint to the relative path
  static Map<Endpoint, String> _path = {
    Endpoint.cases: 'cases',
    Endpoint.casesSuspected: 'casesSuspected',
    Endpoint.casesConfirmed: 'casesConfirmed',
    Endpoint.deaths: 'deaths',
    Endpoint.recovered: 'recovered',
  };
}
