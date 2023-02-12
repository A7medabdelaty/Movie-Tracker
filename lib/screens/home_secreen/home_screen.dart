import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/screens/home_secreen/carusel_slider.dart';
import 'package:movies_app/screens/home_secreen/home_navigator.dart';
import 'package:movies_app/screens/home_secreen/home_view_model.dart';
import 'package:movies_app/shared/styles.dart';

import '../../shared/componets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseView<HomeScreen, HomeViewModel>
    implements HomeNavigator {
  @override
  initViewModel() {
    return HomeViewModel();
  }

  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeViewModel, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeViewModel cubit = HomeViewModel.get(context);
        return Column(
          children: [
            Expanded(
              flex: 7,
              child: ConditionalBuilder(
                condition: cubit.popularMovies.isNotEmpty,
                builder: (context) => CarouselSliderWidget(cubit),
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              flex: 6,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: double.infinity,
                color: MAIN_DARK_COLOR,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Releases',
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
                        condition: cubit.newReleasesMovies.isNotEmpty,
                        builder: (context) => ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              openMovieScreen(cubit.newReleasesMovies[index]);
                            },
                            child:
                                NewReleaseItem(cubit.newReleasesMovies[index]),
                          ),
                          itemCount: cubit.newReleasesMovies.length,
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 10,
                          ),
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
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 9,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                width: double.infinity,
                color: MAIN_DARK_COLOR,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recommended',
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
                        condition: cubit.recommendedMovies.isNotEmpty,
                        builder: (context) => ListView.separated(
                          itemBuilder: (context, index) => InkWell(
                            onTap: () {
                              openMovieScreen(cubit.recommendedMovies[index]);
                            },
                            child: SliderItem(cubit.recommendedMovies[index]),
                          ),
                          separatorBuilder: (context, index) => const SizedBox(
                            width: 7,
                          ),
                          itemCount: cubit.recommendedMovies.length,
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
            ),
          ],
        );
      },
    );
  }
}
