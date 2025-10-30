import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/app_config.dart';
import 'package:movie_app/services/http_service.dart';
import 'package:movie_app/services/movie_service.dart';

class SpalshPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SpalshPage({Key? key, required this.onInitializationComplete})
    : super(key: key);

  @override
  State<SpalshPage> createState() => _SpalshPageState();
}

class _SpalshPageState extends State<SpalshPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1)).then(
      (_) => _setup(context).then((_) => widget.onInitializationComplete()),
    );
  }

  Future<void> _setup(BuildContext _context) async {
    final getIt = GetIt.instance;

    print('Loading configuration...');
    final configFile = await rootBundle.loadString('assets/config/main.json');
    final configData = jsonDecode(configFile);
    print('Config loaded: ${configData.keys}');

    getIt.registerSingleton<AppConfig>(
      AppConfig(
        BASE_API_URL: configData['BASE_API_URL'],
        BASE_IMAGE_API_URL: configData['BASE_IMAGE_API_URL'],
        API_KEY: configData['API_KEY'],
      ),
    );
    print('AppConfig registered');
    print('API URL: ${configData['BASE_API_URL']}');

    getIt.registerSingleton<HttpService>(HttpService());
    print('HttpService registered');

    getIt.registerSingleton<MovieService>(MovieService());
    print('MovieService registered');
    print('All services initialized successfully');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flickd',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.contain,
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
      ),
    );
  }
}
