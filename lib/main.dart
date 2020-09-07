import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/app/services/api_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _accessToken = '';

  // for showing the number of cases we need to declare a state variable
  int _cases;
  int _deaths;

  void _updateAccessToken() async {
    // testing getting accessToken is work correctly
    // we must instatiate APIService class
    final apiService = APIService(API.sanbox());
    
    // if we put getAccessToken here means that access token is requested each time(not necessary), we must request access token when the old one has expired
    // we should implement the necessary logic on a seperate class that we will call "DataRepository"
    final accessToken = await apiService.getAccessToken();

    // testing the endpoints responses for cases
    final cases = await apiService.getEndpointData(
        accessToken: accessToken, endpoint: Endpoint.cases);

    // testing the endpoint responses for deaths
    final deaths = await apiService.getEndpointData(
        accessToken: accessToken, endpoint: Endpoint.deaths);

    // finally we must save accessToken as state variable and rebuild our UI
    // this use of setState method is just use when we want to update one variable
    //setState(() => _accessToken = accessToken);

    // this use of setState method is just use when we want to update more than one variable
    setState(() {
      _accessToken = accessToken;
      _cases = cases;
      _deaths = deaths;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_accessToken',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (_cases != null)
              Text(
                'the number of cases are $_cases',
                style: Theme.of(context).textTheme.headline4,
              ),
              if (_deaths != null)
              Text(
                'the number of deaths are $_deaths',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _updateAccessToken,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
