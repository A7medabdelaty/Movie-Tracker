import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';

import '../../models/MovieModel.dart';
import '../constants.dart';

Widget bookMarkIcon() {
  return InkWell(
    onTap: () {},
    child: SizedBox(
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
    ),
  );
}

Widget newReleaseItem(BuildContext context, Results item) {
  return Container(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
    child: Stack(
      children: [
        Image.network(item.posterPath != null
            ? '$BASE_IMAGE_URL${item.posterPath}'
            : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png'),
        bookMarkIcon(),
      ],
    ),
  );
}

Widget sliderItem(BuildContext context, Results item) {
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
                item.posterPath != null
                    ? '$BASE_IMAGE_URL${item.posterPath}'
                    : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png',
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height * 0.17,
                width: double.infinity,
              ),
              bookMarkIcon(),
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
                      '${item.voteAverage}',
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  child: Text(
                    '${item.title}',
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
                  '${item.releaseDate}',
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
