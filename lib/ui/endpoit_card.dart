import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/services/api.dart';

class EndpointCard extends StatelessWidget {
  final Endpoint endpoint;
  final int value;

  const EndpointCard({Key key, this.endpoint, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cases',
                style: Theme.of(context).textTheme.headline3,
              ),
              // for the checking the value is null or not there two way
              // 1 this below line
              Text(
                value != null ? value.toString() : '',
                style: Theme.of(context).textTheme.headline5,
              ),
              // 2 this below line
              //Text(value?.toString() ?? '')
            ],
          ),
        ),
      ),
    );
  }
}
