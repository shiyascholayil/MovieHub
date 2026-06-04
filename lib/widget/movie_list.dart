import 'package:flutter/material.dart';
import 'package:moviehub/models/movie.dart';
import 'package:moviehub/screens/moviedetails_screen.dart';
import 'package:moviehub/widget/movie_card.dart';



class MovieList extends StatelessWidget {
  const MovieList({
    super.key,
    required this.movies,
  });

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return Center(child: Text("No Movies available "));
    }

    return GridView.builder(
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return MovieCard(movie: movies[index],
         onTap: () {
           Navigator.push(context,MaterialPageRoute(
            builder:(context)=>
                   MovieDetailScreen(movie:movies[index]),
             ),);
         },
        );
        
      },
    );
  }
}
