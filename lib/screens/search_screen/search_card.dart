import 'package:flutter/material.dart';
import 'package:movies_app/models/MovieModel.dart';

class SearchCard extends StatelessWidget {
  const SearchCard(Results this.movieItem, {Key? key}) : super(key: key);
  final Results? movieItem;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Image.network(
            movieItem?.posterPath != null
                ? 'https://image.tmdb.org/t/p/w300${movieItem?.posterPath}'
                : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png',
            width: MediaQuery.of(context).size.width * 0.30,
            height: MediaQuery.of(context).size.width * 0.25,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Text(
                  '${movieItem?.title}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Text('Date: ${movieItem?.releaseDate}',
                  style: const TextStyle(color: Colors.white)),
              Text('Rate: ${movieItem?.voteAverage}',
                  style: const TextStyle(color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}
