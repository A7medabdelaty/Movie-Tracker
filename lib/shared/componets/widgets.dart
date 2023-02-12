import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../cubit/cubit.dart';
import '../../models/movie_model.dart';
import '../constants.dart';

Widget bookMarkIcon() {
  return SizedBox(
    width: 25,
    child: Stack(
      alignment: Alignment.topCenter,
      children: const [
        Icon(
          FontAwesomeIcons.solidBookmark,
          color: Color(0xff514F4F),
          size: 35,
        ),
        Icon(
          Ionicons.add,
          size: 25,
          color: Colors.white,
        ),
      ],
    ),
  );
}

Widget activeBookMarkIcon() {
  return SizedBox(
    width: 25,
    child: Stack(
      alignment: Alignment.topCenter,
      children: [
        const Icon(
          FontAwesomeIcons.solidBookmark,
          color: Color(0xffF7B539),
          size: 35,
        ),
        Container(
          margin: const EdgeInsets.only(top: 5),
          child: const Icon(
            FontAwesomeIcons.check,
            size: 20,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

class SliderItem extends StatefulWidget {
  final Results item;

  const SliderItem(this.item, {Key? key}) : super(key: key);

  @override
  State<SliderItem> createState() => _SliderItemState();
}

class _SliderItemState extends State<SliderItem> {
  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = MovieCubit.get(context);
    return Card(
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.all(0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: const Color(0xff343534),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.25,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Image.network(
                  widget.item.posterPath != null
                      ? '$BASE_IMAGE_URL${widget.item.posterPath}'
                      : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png',
                  fit: BoxFit.cover,
                  height: MediaQuery.of(context).size.height * 0.17,
                  width: double.infinity,
                ),
                InkWell(
                  onTap: () {
                    movieCubit.onBookMarkTab(widget.item);
                    setState(() {});
                  },
                  child: widget.item.inWatchList!
                      ? activeBookMarkIcon()
                      : bookMarkIcon(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xffFFBB3B),
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        '${widget.item.voteAverage}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  SizedBox(
                    child: Text(
                      '${widget.item.title}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Text(
                    '${widget.item.releaseDate}',
                    style: const TextStyle(color: Colors.white, fontSize: 8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewReleaseItem extends StatefulWidget {
  final Results item;

  const NewReleaseItem(this.item, {Key? key}) : super(key: key);

  @override
  State<NewReleaseItem> createState() => _NewReleaseItemState();
}

class _NewReleaseItemState extends State<NewReleaseItem> {
  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = MovieCubit.get(context);
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Stack(
        children: [
          Image.network(widget.item.posterPath != null
              ? '$BASE_IMAGE_URL${widget.item.posterPath}'
              : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png'),
          InkWell(
            onTap: () {
              movieCubit.onBookMarkTab(widget.item);
              setState(() {});
            },
            child: widget.item.inWatchList!
                ? activeBookMarkIcon()
                : bookMarkIcon(),
          ),
        ],
      ),
    );
  }
}
