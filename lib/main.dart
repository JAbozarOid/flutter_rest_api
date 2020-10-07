import 'package:flutter/material.dart';
import 'package:flutter_rest_api/app/repositories/data_repository.dart';
import 'package:flutter_rest_api/app/services/api.dart';
import 'package:flutter_rest_api/app/services/api_service.dart';
import 'package:flutter_rest_api/app/services/data_cache_service.dart';
import 'package:flutter_rest_api/ui/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // we must call this method before calling SharedPreferences.getInstance() method
  WidgetsFlutterBinding.ensureInitialized();

  Intl.defaultLocale = 'en_GB';
  await initializeDateFormatting();
  // the strategy for sharedPreferences here is to get value asynchronously in void main()
  // and make it available synchronously to the rest of the app
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      // when don't need the variable use _
      create: (_) => DataRepository(
          apiService: APIService(API.sanbox()),
          dataCacheService:
              DataCacheService(sharedPreferences: sharedPreferences)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Coronavirus Tracker',
        theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Color(0xFF101010),
            cardColor: Color(0xFF222222)),
        home: Dashboard(),
      ),
    );
  }
}
