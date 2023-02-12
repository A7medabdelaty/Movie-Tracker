import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/cubit.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/screens/home_secreen/home_view_model.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/shared/constants.dart';

import '../../shared/componets/widgets.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget(this.cubit, {Key? key}) : super(key: key);
  final HomeViewModel cubit;

  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = MovieCubit.get(context);
    return BlocConsumer<MovieCubit, MovieStates>(
      builder: (context, state) {
        return CarouselSlider(
          items: widget.cubit.popularMovies.map((item) {
            return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, MovieDetailsScreen.routeName,
                      arguments: item);
                },
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.28,
                  child: Stack(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.20,
                            child: Image.network(
                              '$BASE_IMAGE_URL${item.backdropPath}',
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_circle_fill,
                              size: 50,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Stack(
                                alignment: Alignment.topLeft,
                                children: [
                                  Image.network(
                                    'https://image.tmdb.org/t/p/w300/${item.posterPath}',
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    fit: BoxFit.cover,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      movieCubit.onBookMarkTab(item);
                                      setState(() {});
                                    },
                                    child: item.inWatchList!
                                        ? activeBookMarkIcon()
                                        : bookMarkIcon(),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.7,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      '${item.title}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      '${item.voteAverage} | ${item.releaseDate}',
                                      style: const TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ));
          }).toList(),
          options: CarouselOptions(
              autoPlay: true,
              height: MediaQuery.of(context).size.height * 0.28,
              viewportFraction: 1),
        );
      },
      listener: (context, state) {},
    );
  }
}
