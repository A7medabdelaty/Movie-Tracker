import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/shared/constants.dart';
import 'package:movies_app/shared/network/remote/dio.dart';

import '../../models/CategoryModel.dart';

class BrowseViewModel extends BaseViewModel {
  static BrowseViewModel get(BuildContext context) => BlocProvider.of(context);

  List<Genres> categories = [];

  void getCategories() {
    emit(GetCategoriesLoadingState());
    DioHelper.getData(
      url: CATEGORIES_END_POINT,
      query: {'api_key': API_KEY},
    ).then((value) {
      categories = CategoryModel.fromJson(value?.data).genres!;
      emit(GetCategoriesSuccessState());
    }).catchError((e) {
      print(e);
      emit(GetCategoriesErrorState());
    });
  }

  List<Results> genresMovies = [];

  void getMoviesByGenres(Genres genre) {
    emit(GetGenresMoviesLoadingState());
    DioHelper.getData(
        url: DISCOVER_END_POINT,
        query: {'api_key': API_KEY, 'with_genres': genre.id}).then((value) {
      genresMovies = MovieModel.fromJson(value?.data).results!;
      emit(GetGenresMoviesSuccessState());
    }).catchError((e) {
      emit(GetGenresMoviesErrorState());
      print(e);
    });
  }
}
