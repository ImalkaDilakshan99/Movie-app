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

class MainPage extends ConsumerWidget {
  double _deviceHeight = 0;
  double _deviceWidth = 0;

  MainPageDataController? _mainPageDataController;
  MainPageData? _mainPageData;

  TextEditingController? _searchTextFieldController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    _mainPageDataController = ref.watch(
      mainPageDataControllerProvider.notifier,
    );
    _mainPageData = ref.watch(mainPageDataControllerProvider);

    print(
      'MainPage rebuild - Movies count: ${_mainPageData?.movies.length ?? 0}',
    );

    _searchTextFieldController = TextEditingController();
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        height: _deviceHeight,
        width: _deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [_backgroundWidget(), _foregroundWidgets()],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    return Container(
      height: _deviceHeight,
      width: _deviceWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        image: DecorationImage(
          image: NetworkImage(
            'https://plus.unsplash.com/premium_photo-1755534520242-75aaf271b790?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
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
  }

  Widget _foregroundWidgets() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _deviceHeight * 0.02, 0, 0),
      width: _deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(),
          Container(
            height: _deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: _deviceHeight * 0.01),
            child: _moviesListViewWidget(),
          ),
        ],
      ),
    );
  }

  Widget _topBarWidget() {
    return Container(
      height: _deviceHeight * 0.08,
      decoration: BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_searchFieldWidget(), _categorySelectionWidget()],
      ),
    );
  }

  Widget _searchFieldWidget() {
    final _border = InputBorder.none;
    return Container(
      width: _deviceWidth * 0.50,
      height: _deviceHeight * 0.05,
      child: TextField(
        controller: _searchTextFieldController,
        onSubmitted: (_input) {},
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

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: _mainPageData?.searchCategory,
      icon: Icon(Icons.menu, color: Colors.white24),
      underline: Container(height: 1, color: Colors.white24),
      onChanged: (_value) => _value.toString().isNotEmpty
          ? _mainPageDataController?.updateSearchCategory(_value!)
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

  Widget _moviesListViewWidget() {
    final List<Movie> _movies = _mainPageData!.movies;

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
      return ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (BuildContext _context, int _count) {
          return Padding(
            padding: EdgeInsets.symmetric(
              vertical: _deviceHeight * 0.01,
              horizontal: 0,
            ),
            child: GestureDetector(
              onTap: () {},
              child: MovieTile(
                movie: _movies[_count],
                height: _deviceHeight * 0.20,
                width: _deviceWidth * 0.85,
              ),
            ),
          );
        },
      );
    } else {
      return Center(
        child: CircularProgressIndicator(backgroundColor: Colors.white),
      );
    }
  }
}
