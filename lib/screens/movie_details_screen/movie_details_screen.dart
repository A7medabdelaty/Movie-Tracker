import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/models/MovieModel.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_navigator.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_view_model.dart';
import 'package:movies_app/shared/constants.dart';

import '../../shared/componets/widgets.dart';

class MovieDetailsScreen extends StatefulWidget {
  const MovieDetailsScreen({Key? key}) : super(key: key);
  static const String routeName = 'movie details';

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState
    extends BaseView<MovieDetailsScreen, MovieDetailsViewModel>
    implements MovieDetailsNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: const Color(0xff1A1A1A),
        systemNavigationBarColor: const Color(0xff1A1A1A),
      ),
    );
    Results movie = ModalRoute.of(context)?.settings.arguments as Results;
    return BlocProvider(
      create: (context) => MovieDetailsViewModel()..getSimilarMovies(movie.id!),
      child: Scaffold(
        backgroundColor: const Color(0xff1A1A1A),
        appBar: AppBar(
          backgroundColor: const Color(0xff1A1A1A),
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          title: Text(
            '${movie.title}',
          ),
        ),
        body: BlocConsumer<MovieDetailsViewModel, MovieStates>(
          listener: (context, state) {},
          builder: (context, state) {
            MovieDetailsViewModel cubit = MovieDetailsViewModel.get(context);
            return FutureBuilder(
              future: viewModel.getMovieDetails(movie.id!),
              builder: (context, snapshot) {
                return ConditionalBuilder(
                  condition: snapshot.data != null,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.network(
                                snapshot.data?.backdropPath != null
                                    ? '$BASE_IMAGE_URL${snapshot.data?.backdropPath}'
                                    : 'https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-1-scaled-1150x647.png',
                                width: double.infinity,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                fit: BoxFit.cover,
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
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${snapshot.data?.title}',
                                  style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  '${snapshot.data?.releaseDate} | ${snapshot.data?.originalLanguage}',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 10),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.35,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Stack(
                                          children: [
                                            Image.network(
                                              '$BASE_IMAGE_URL${snapshot.data?.posterPath}',
                                            ),
                                            bookMarkIcon(),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.55,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Wrap(
                                              runAlignment: WrapAlignment.start,
                                              direction: Axis.horizontal,
                                              spacing: 5,
                                              runSpacing: 5,
                                              verticalDirection:
                                                  VerticalDirection.down,
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.start,
                                              children: snapshot.data?.genres
                                                  ?.map((e) {
                                                return Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  child: Text(
                                                    '${e.name}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                );
                                              }).toList() as List<Widget>,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                                child: Text(
                                              '${snapshot.data?.overview}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            )),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                const Icon(
                                                  Icons.star_rounded,
                                                  color: Color(0xffFFBB3B),
                                                ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '${snapshot.data?.voteAverage}',
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.35,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            width: double.infinity,
                            color: const Color(0xff282A28),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'More Like This',
                                  style: GoogleFonts.abel(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Expanded(
                                  child: ConditionalBuilder(
                                    condition: cubit.similarMovies.isNotEmpty,
                                    builder: (context) => ListView.separated(
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          openMovieScreen(
                                              cubit.similarMovies[index]);
                                        },
                                        child: sliderItem(context,
                                            cubit.similarMovies[index]),
                                      ),
                                      separatorBuilder: (context, index) =>
                                          const SizedBox(
                                        width: 7,
                                      ),
                                      itemCount: cubit.similarMovies.length,
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                    ),
                                    fallback: (context) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  MovieDetailsViewModel initViewModel() {
    return MovieDetailsViewModel();
  }
}
