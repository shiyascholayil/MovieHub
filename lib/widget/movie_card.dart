import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:moviehub/const.dart';
import 'package:moviehub/models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final VoidCallback onTap;
  const MovieCard({super.key,required this.movie,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(8),
          color: primaryColor,
           boxShadow:[
                    BoxShadow(
                               color: secondaryColor.withValues(alpha:0.1),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
         
         child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child:ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(8)
                ),
                child: CachedNetworkImage(
                  imageUrl:movie.fullBackDropUrl,
                  fit:BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) => Container(
                    color: loadingColor,
                    child: Center(
                      child: CircularProgressIndicator(
                         strokeWidth: 7,
                      ),
                    ),
                  ),
                   errorWidget: (context, url, error) => Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.broken_image),
                    ),
                
                ),
              )
            ),
            Expanded(
              flex: 1,
              child:Padding
              ( padding: EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       Text(movie.title,style:filmTextStyle,
                        maxLines:1,
                      overflow: TextOverflow.ellipsis,
                       ),
                       
                         SizedBox(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                               Icon(Icons.star,color: starIconColor,),
                              Text(movie.voteAverage.toStringAsFixed(1),style:ratingTextStyle,),
                              
                            ],
                          ),
                         ),
                          
                      ],
                    ),
                  ),
              ),
               ),
          ],
         ),
      ),
    );
  }
}