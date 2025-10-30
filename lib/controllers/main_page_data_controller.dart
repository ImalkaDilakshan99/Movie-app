import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/services/movie_service.dart';

class MainPageDataController extends StateNotifier<MainPageData> {
  MainPageDataController([MainPageData? state])
    : super(state ?? MainPageData.inital()) {
    getMovies();
  }

  final MovieService _movieService = GetIt.instance.get<MovieService>();

  Future<void> getMovies() async {
    try {
      print('Starting to fetch movies for page: ${state.page}');
      List<Movie> _movies = [];
      _movies = await _movieService.getPopularMovies(page: state.page);
      print('Successfully fetched ${_movies.length} movies');
      state = state.copyWith(
        movies: [...state.movies, ..._movies],
        page: state.page + 1,
      );
      print('Total movies now: ${state.movies.length}');
    } catch (e, stackTrace) {
      print('Error loading movies: $e');
      print('Stack trace: $stackTrace');
    }
  }
}
