import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/screens/moviedetails_screen.dart';
import 'package:moviehub/widget/movie_card.dart';

class MovieList extends StatefulWidget {
  const MovieList({super.key, required this.movies});

  final List<Movie> movies;

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  late final Box<Movie> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Movie>('favorites');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.movies.isEmpty) {
      return const Center(
        child: Text(
          "No Movies Available",
          style: TextStyle(color: Colors.white70),
        ),
      );
    }

    final width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 600 ? 3 : 2;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: widget.movies.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        
          childAspectRatio: 0.65, 
        ),
        itemBuilder: (context, index) {
          final movie = widget.movies[index];

          return MovieCard(
            movie: movie,
            isFavorite: box.containsKey(movie.id),
            onFavoritePressed: () {
              setState(() {
                if (box.containsKey(movie.id)) {
                  box.delete(movie.id);
                } else {
                  box.put(movie.id, movie);
                }
              });
            },
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, _, _) =>
                      MovieDetailScreen(movie: movie),
                  transitionsBuilder: (_, animation, _, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}