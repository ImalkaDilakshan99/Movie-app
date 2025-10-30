import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/app_config.dart';

class HttpService {
  final Dio dio = Dio();
  final GetIt getIt = GetIt.instance;

  late String _base_url;
  late String _api_key;

  HttpService() {
    AppConfig _config = getIt.get<AppConfig>();
    _base_url = _config.BASE_API_URL;
    _api_key = _config.API_KEY;
  }

  Future<Response> get(String _path, {Map<String, dynamic>? query}) async {
    try {
      String _url = '$_base_url$_path';
      Map<String, dynamic> _query = {'api_key': _api_key, 'language': 'en-US'};
      if (query != null) {
        _query.addAll(query);
      }
      print('Making GET request to: $_url');
      print('Query params: $_query');
      Response response = await dio.get(_url, queryParameters: _query);
      print('Response status: ${response.statusCode}');
      return response;
    } on DioException catch (e) {
      print('Unable to perform get request.');
      print('DioError: ${e.message}');
      print('Response: ${e.response?.data}');
      rethrow;
    }
  }
}
