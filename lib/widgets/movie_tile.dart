import 'package:flutter/material.dart';
import 'package:movie_app/models/movie.dart';

class MovieTile extends StatelessWidget {
  final double? height;
  final double? width;
  final Movie? movie;

  const MovieTile({super.key, this.movie, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    final String imageUrl =
        movie?.posterURL() ?? 'https://via.placeholder.com/150';
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [_moviePosterWidget(imageUrl), _movieInfoWidget()],
      ),
    );
  }

  Widget _movieInfoWidget() {
    return Container(
      height: height,
      width: width! * 0.66,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  child: Text(
                    movie!.name ?? 'Unknown',
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                constraints: BoxConstraints(maxWidth: width! * 0.15),
                child: Text(
                  (movie?.rating ?? 0.0).toString(),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, height! * 0.02, 0, 0),
            child: Text(
              '${movie?.language?.toUpperCase()} | R: ${movie?.isAdult} | ${movie?.releaseDate}',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, height! * 0.07, 0, 0),
              child: Text(
                movie!.description ?? 'No Description Available',
                maxLines: 9,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.white70, fontSize: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _moviePosterWidget(String _imageURL) {
    return Container(
      height: height,
      width: width! * 0.35,
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(_imageURL)),
      ),
    );
  }
}
