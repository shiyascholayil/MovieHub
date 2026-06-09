import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/widget/movie_card.dart';
import 'package:moviehub/screens/moviedetails_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final box = Hive.box<Movie>('favorites');

  List<Movie> get favoriteMovies => box.values.toList();

  void toggleFavorite(Movie movie) {
    setState(() {
     
        box.delete(movie.id);
      
    
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = favoriteMovies;

    if (movies.isEmpty) {
      return Scaffold(
       
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.favorite_border,
                size: 80,
                color: greyShade600,
              ),
              const SizedBox(height: 16),
              Text(
                "No favorite movies yet",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: greyShade400
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Tap the ❤️ icon on any movie to add it here",
                style: TextStyle(fontSize: 14, color: greyShade500),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 120,
            floating: true,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "My Favorites",
                style: TextStyle(
                  fontSize: 24,
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      secondaryColor,
                      const Color.fromARGB(221, 143, 141, 141),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(12),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.68,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final movie = movies[index];

                return TweenAnimationBuilder(
                  duration: Duration(milliseconds: 300 + (index * 50)),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: MovieCard(
                    movie: movie,
                    isFavorite: true,
                    onFavoritePressed: () {

                      toggleFavorite(movie);
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
                              child: ScaleTransition(
                                scale: Tween<double>(
                                  begin: 0.95,
                                  end: 1,
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 400),
                        ),
                      );
                    },
                  ),
                );
              }, childCount: movies.length),
            ),
          ),
        ],
      ),
    );
  }
}
