
import 'package:flutter/material.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/riverpod/movie_riverpod.dart';
import 'package:moviehub/screens/moviedetails_screen.dart';
import 'package:moviehub/widget/loading_widget.dart';

class SearchList extends StatelessWidget {
  const SearchList({
    super.key,
    required this.movieprovider,
    required this.searchController,
  });

  final MovieProvider movieprovider;
  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {

    if (movieprovider.isLoading) {
      return const Center(
        child: LoadingWidget(message: 'Loading..'),
      );
    }

    if (searchController.text.isEmpty) {
      return  Center(
        child: Text(
          'Start typing to search movies',
          style: TextStyle(color: secondaryColor),
        ),
      );
    }

    if (movieprovider.searchResult.isEmpty) {
      return  Center(
        child: Text(
          "No Movie Found",
          style: TextStyle(color: secondaryColor),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: movieprovider.searchResult.length,
      separatorBuilder: (_, _) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final movie = movieprovider.searchResult[index];

        return _buildMovieTile(context, movie);
      },
    );
  }

  Widget _buildMovieTile(BuildContext context, movie) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: secondaryColor.withValues(alpha:0.08),
          ),
          boxShadow: [
            BoxShadow(
              color: secondaryColor.withValues(alpha:0.04),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                movie.fullPosterUrl,
                width: 55,
                height: 75,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return Container(
                    width: 55,
                    height: 75,
                    color: secondaryColor.withValues(alpha: 0.05),
                    child:  Icon(
                      Icons.broken_image_outlined,
                      color: secondaryColor,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style:  TextStyle(
                      color: secondaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    "Rating ${movie.voteAverage.toStringAsFixed(1)}",
                    style: TextStyle(
                      color: secondaryColor.withValues(alpha: 0.6),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),

             Icon(
              Icons.chevron_right_rounded,
              color: secondaryColor,
            ),
          ],
        ),
      ),
    );
  }
}