import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_app/controllers/main_page_data_controller.dart';
import 'package:movie_app/models/main_page_data.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/search_category.dart';
import 'package:movie_app/widgets/movie_tile.dart';

final mainPageDataControllerProvider =
    StateNotifierProvider<MainPageDataController, MainPageData>((ref) {
      return MainPageDataController();
    });

final selectedMoviePosterURLProvider = StateProvider<String?>((ref) {
  final _movies = ref.watch(mainPageDataControllerProvider).movies;
  return _movies.length != 0 ? _movies[0].posterURL() : null;
});

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    final mainPageDataController = ref.watch(
      mainPageDataControllerProvider.notifier,
    );
    final mainPageData = ref.watch(mainPageDataControllerProvider);
    final searchTextFieldController = TextEditingController();
    searchTextFieldController.text = mainPageData.searchText;

    final _selectedMoviePosterURL = ref.watch(selectedMoviePosterURLProvider);

    return _buildUI(
      deviceHeight,
      deviceWidth,
      mainPageDataController,
      mainPageData,
      searchTextFieldController,
      _selectedMoviePosterURL,
      ref, // Add this argument
    );
  }

  Widget _buildUI(
    double deviceHeight,
    double deviceWidth,
    MainPageDataController mainPageDataController,
    MainPageData mainPageData,
    TextEditingController searchTextFieldController,
    String? selectedMoviePosterURL,
    WidgetRef ref, // Add this parameter
  ) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: deviceHeight,
        width: deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(
              deviceHeight,
              deviceWidth,
              selectedMoviePosterURL,
            ),
            _foregroundWidgets(
              deviceHeight,
              deviceWidth,
              mainPageDataController,
              mainPageData,
              searchTextFieldController,
              ref, // Pass ref to foreground widgets
            ),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget(
    double deviceHeight,
    double deviceWidth,
    String? selectedMoviePosterURL,
  ) {
    if (selectedMoviePosterURL != null) {
      return Container(
        height: deviceHeight,
        width: deviceWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          image: DecorationImage(
            image: NetworkImage(selectedMoviePosterURL),
            fit: BoxFit.cover,
          ),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
          child: Container(
            decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
          ),
        ),
      );
    } else {
      return Container(
        height: deviceHeight,
        width: deviceWidth,
        color: Colors.black,
      );
    }
  }

  Widget _foregroundWidgets(
    double deviceHeight,
    double deviceWidth,
    MainPageDataController mainPageDataController,
    MainPageData mainPageData,
    TextEditingController searchTextFieldController,
    WidgetRef ref,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, deviceHeight * 0.02, 0, 0),
      width: deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(
            deviceHeight,
            deviceWidth,
            mainPageDataController,
            mainPageData,
            searchTextFieldController,
          ),
          Container(
            height: deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: _moviesListViewWidget(
              deviceHeight,
              deviceWidth,
              mainPageData,
              mainPageDataController,
              ref,
            ),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget(
    double deviceHeight,
    double deviceWidth,
    MainPageDataController mainPageDataController,
    MainPageData mainPageData,
    TextEditingController searchTextFieldController,
  ) {
    return Container(
      height: deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(
            deviceHeight,
            deviceWidth,
            mainPageDataController,
            searchTextFieldController,
          ),
          _categorySelectionWidget(mainPageDataController, mainPageData),
        ],
      ),
    );
  }

  Widget _searchFieldWidget(
    double deviceHeight,
    double deviceWidth,
    MainPageDataController mainPageDataController,
    TextEditingController searchTextFieldController,
  ) {
    final _border = InputBorder.none;
    return Container(
      width: deviceWidth * 0.50,
      height: deviceHeight * 0.05,
      child: TextField(
        controller: searchTextFieldController,
        onSubmitted: (_input) =>
            mainPageDataController.updateTextSearch(_input),
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          focusedBorder: _border,
          border: _border,
          prefixIcon: Icon(Icons.search, color: Colors.white),
          hintStyle: TextStyle(color: Colors.white54),
          filled: false,
          fillColor: Colors.white24,
          hintText: 'Search...',
        ),
      ),
    );
  }

  Widget _categorySelectionWidget(
    MainPageDataController mainPageDataController,
    MainPageData mainPageData,
  ) {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: mainPageData.searchCategory,
      icon: Icon(Icons.menu, color: Colors.white24),
      underline: Container(height: 1, color: Colors.white24),
      onChanged: (_value) => _value.toString().isNotEmpty
          ? mainPageDataController.updateSearchCategory(_value!)
          : null,
      items: [
        DropdownMenuItem(
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.popular,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.upcoming,
        ),
        DropdownMenuItem(
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
          value: SearchCategory.none,
        ),
      ],
    );
  }

  Widget _moviesListViewWidget(
    double deviceHeight,
    double deviceWidth,
    MainPageData mainPageData,
    MainPageDataController mainPageDataController,
    WidgetRef ref,
  ) {
    final List<Movie> _movies = mainPageData.movies;

    // for (var i = 0; i < 20; i++) {
    //   _movies.add(
    //     Movie(
    //       name: "Imalka film",
    //       language: "Sinhala",
    //       isAdult: false,
    //       description:
    //           "You need to ensure the value is non-null before passing it.If you are sure the value is never null, use the null assertion",
    //       posterPath: "/yvirUYrva23IudARHn3mMGVxWqM.jpg",
    //       backdropPath: "/iZLqwEwUViJdSkGVjePGhxYzbDb.jpg",
    //       rating: 4.5,
    //       releaseDate: "2025-11-22",
    //     ),
    //   );
    // }

    if (_movies.length != 0) {
      return NotificationListener(
        onNotification: (_onScrollNotification) {
          if (_onScrollNotification is ScrollEndNotification) {
            final before = _onScrollNotification.metrics.extentBefore;
            final max = _onScrollNotification.metrics.maxScrollExtent;
            if (before == max) {
              mainPageDataController.getMovies();
              return true;
            }
            return false;
          }
          return false;
        },
        child: ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (BuildContext _context, int _count) {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: deviceHeight * 0.01,
                horizontal: 0,
              ),
              child: GestureDetector(
                onTap: () {
                  ref.read(selectedMoviePosterURLProvider.notifier).state =
                      _movies[_count].posterURL();
                },
                child: MovieTile(
                  movie: _movies[_count],
                  height: deviceHeight * 0.20,
                  width: deviceWidth * 0.85,
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      );
    }
  }
}
