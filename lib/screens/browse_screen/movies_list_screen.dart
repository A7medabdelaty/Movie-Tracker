import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/screens/browse_screen/browse_view_model.dart';

import '../../cubit/cubit_states.dart';
import '../../models/CategoryModel.dart';
import '../../shared/styles.dart';
import '../search_screen/search_card.dart';

class BrowseMovies extends StatefulWidget {
  const BrowseMovies({Key? key}) : super(key: key);
  static const String routeName = 'browse movies';

  @override
  State<BrowseMovies> createState() => _BrowseMoviesState();
}

class _BrowseMoviesState extends State<BrowseMovies> {
  @override
  Widget build(BuildContext context) {
    Genres? data = ModalRoute.of(context)?.settings.arguments as Genres?;
    BrowseViewModel cubit = BrowseViewModel.get(context);
    return BlocConsumer<BrowseViewModel, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) => Scaffold(
        backgroundColor: MAIN_DARK_COLOR,
        appBar: AppBar(
          backgroundColor: MAIN_DARK_COLOR,
          iconTheme: const IconThemeData(color: Colors.white),
          titleTextStyle: const TextStyle(color: Colors.white),
          title: Text(
            '${data?.name}',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ConditionalBuilder(
                  condition: cubit.genresMovies.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => SearchCard(
                      cubit.genresMovies[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: cubit.genresMovies.length,
                  ),
                  fallback: (context) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.local_movies,
                          color: Color(0xffB5B4B4),
                          size: 100,
                        ),
                        Text(
                          'No Movies Found',
                          style: TextStyle(
                            color: Color(0xffB5B4B4),
                            fontSize: 13,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
