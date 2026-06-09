import 'package:flutter/material.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/riverpod/movie_riverpod.dart';
import 'package:moviehub/widget/loading_widget.dart';
import 'package:moviehub/widget/movie_list.dart';

class TabContent extends StatelessWidget {
  const TabContent({
    super.key,
    required TabController tabController,
    required this.movieprovider,
  }) : _tabController = tabController;

  final TabController _tabController;
  final MovieProvider movieprovider;

  @override
  Widget build(BuildContext context) {
    if (movieprovider.isLoading) {
      return const Center(
        child: LoadingWidget(message: 'Loading...'),
      );
    }

    if (movieprovider.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 60,
                color: redColor,
              ),
              const SizedBox(height: 16),
              Text(
                movieprovider.errorMessage!,
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontSize: 15,
                  color: secondaryColor,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () => movieprovider.loadMovies(),
                icon: const Icon(Icons.refresh),
                label: const Text("Retry"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: secondaryColor,
                  foregroundColor: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return TabBarView(
      controller: _tabController,
      children: [
        MovieList(movies: movieprovider.nowPlayingMovies),
        MovieList(movies: movieprovider.popularMovies),
        MovieList(movies: movieprovider.topRatedMovies),
        MovieList(movies: movieprovider.upcomingMovies),
      ],
    );
  }
}