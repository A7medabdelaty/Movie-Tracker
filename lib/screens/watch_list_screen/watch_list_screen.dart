import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/screens/search_screen/search_card.dart';
import 'package:movies_app/screens/watch_list_screen/watch_list_navigator.dart';
import 'package:movies_app/screens/watch_list_screen/watch_list_view_model.dart';

import '../../cubit/cubit.dart';

class WatchListScreen extends StatefulWidget {
  const WatchListScreen({Key? key}) : super(key: key);

  @override
  State<WatchListScreen> createState() => _WatchListScreenState();
}

class _WatchListScreenState
    extends BaseView<WatchListScreen, WatchListViewModel>
    implements WatchListNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    MovieCubit movieCubit = MovieCubit.get(context);
    movieCubit.getWatchListMovies();
    return BlocConsumer<WatchListViewModel, MovieStates>(
      buildWhen: (previous, current) {
        return current != previous;
      },
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Watchlist',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ConditionalBuilder(
                  condition: movieCubit.watchList.isNotEmpty,
                  builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => SearchCard(
                      movieCubit.watchList[index],
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: movieCubit.watchList.length,
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
                          'No Movies Yet',
                          style: TextStyle(
                            color: Color(0xffB5B4B4),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  WatchListViewModel initViewModel() {
    return WatchListViewModel();
  }
}
