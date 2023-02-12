import 'package:flutter/material.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';

import '../../shared/componets/widgets.dart';

class SearchCard extends StatefulWidget {
  const SearchCard(this.movieItem, {Key? key}) : super(key: key);
  final Results movieItem;

  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
  @override
  Widget build(BuildContext context) {
    final MovieCubit movieCubit = MovieCubit.get(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MovieDetailsScreen.routeName,
            arguments: widget.movieItem);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
                  child: Image.network(
                    widget.movieItem.posterPath != null
                        ? 'https://image.tmdb.org/t/p/w300${widget.movieItem.posterPath}'
                        : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png',
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.width * 0.25,
                    fit: BoxFit.cover,
                  ),
                ),
                InkWell(
                  onTap: () {
                    movieCubit.onBookMarkTab(widget.movieItem);
                    setState(() {});
                  },
                  child: widget.movieItem.inWatchList!
                      ? activeBookMarkIcon()
                      : bookMarkIcon(),
                ),
              ],
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
                    '${widget.movieItem.title}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Text('Date: ${widget.movieItem.releaseDate}',
                    style: const TextStyle(color: Colors.white)),
                Text('Rate: ${widget.movieItem.voteAverage}',
                    style: const TextStyle(color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
