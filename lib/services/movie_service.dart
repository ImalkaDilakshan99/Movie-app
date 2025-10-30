import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/http_service.dart';

class MovieService {
  final GetIt getIt = GetIt.instance;

  late HttpService _http;

  MovieService() {
    _http = getIt.get<HttpService>();
  }

  Future<List<Movie>> getPopularMovies({int? page}) async {
    print('MovieService: Fetching popular movies for page: $page');
    Response _response = await _http.get(
      'movie/popular',
      query: {'page': page},
    );

    if (_response.statusCode == 200) {
      Map _data = _response.data;
      print('Response data keys: ${_data.keys}');
      print('Results count: ${_data['results']?.length ?? 0}');
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      print('Parsed ${_movies.length} movies');
      return _movies;
    } else {
      print('Bad status code: ${_response.statusCode}');
      throw Exception('Couldn\' t load popular movies');
    }
  }

  Future<List<Movie>> getUpcomingMovies({int? page}) async {
    print('MovieService: Fetching popular movies for page: $page');
    Response _response = await _http.get(
      'movie/upcoming',
      query: {'page': page},
    );

    if (_response.statusCode == 200) {
      Map _data = _response.data;
      print('Response data keys: ${_data.keys}');
      print('Results count: ${_data['results']?.length ?? 0}');
      List<Movie> _movies = _data['results'].map<Movie>((_movieData) {
        return Movie.fromJson(_movieData);
      }).toList();
      print('Parsed ${_movies.length} movies');
      return _movies;
    } else {
      print('Bad status code: ${_response.statusCode}');
      throw Exception('Couldn\' t load popular movies');
    }
  }
}
