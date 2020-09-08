import 'package:flutter/foundation.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/app/services/api_service.dart';

class DataRepository {
  final APIService apiService;

  DataRepository({@required this.apiService});

  // use this method to get data for giving endpoint
  Future<int> getEndpointData(Endpoint endpoint) async {
    final accessToken = await apiService.getAccessToken();
    return await apiService.getEndpointData(
        accessToken: accessToken, endpoint: endpoint);
  }
}
