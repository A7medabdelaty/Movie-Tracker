import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';

import 'models/movie_model.dart';

abstract class BaseNavigator {
  void openMovieScreen(Results movie);
}

class BaseViewModel<NAV extends BaseNavigator> extends Cubit<MovieStates> {
  BaseViewModel() : super(InitMoviesState());
  NAV? navigator;
}

abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T>
    implements BaseNavigator {
  late VM viewModel;

  VM initViewModel();

  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }

  @override
  void openMovieScreen(Results movie) {
    Navigator.pushNamed(context, MovieDetailsScreen.routeName, arguments: movie);
  }
}
