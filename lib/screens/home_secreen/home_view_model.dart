import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/shared/constants.dart';
import 'package:movies_app/shared/network/remote/dio.dart';

import '../../models/MovieModel.dart';

class HomeViewModel extends BaseViewModel {
  static HomeViewModel get(context) => BlocProvider.of(context);

  List<Results> recommendedMovies = [];

  void getRecommendedMovies() {
    emit(GetRecommendedMovieLoadingState());
    DioHelper.getData(url: TOP_RATED_END_POINT, query: {'api_key': API_KEY})
        .then((value) {
      recommendedMovies = MovieModel.fromJson(value?.data).results!;
      emit(GetRecommendedMovieSuccessState());
    }).catchError((e) {
      print(e);
      emit(GetRecommendedMovieErrorState());
    });
  }

  List<Results> newReleasesMovies = [];

  void getNewReleaseMovies() {
    emit(GetRecommendedMovieLoadingState());
    DioHelper.getData(url: UP_COMMING_END_POINT, query: {'api_key': API_KEY})
        .then((value) {
      newReleasesMovies = MovieModel.fromJson(value?.data).results!;
      emit(GetNewReleaseMovieSuccessState());
    }).catchError((e) {
      print(e);
      emit(GetNewReleaseMovieErrorState());
    });
  }

  List<Results> popularMovies = [];

  void getPopularMovies() {
    emit(GetRecommendedMovieLoadingState());
    DioHelper.getData(url: POPULAR_END_POINT, query: {'api_key': API_KEY})
        .then((value) {
      popularMovies = MovieModel.fromJson(value?.data).results!;
      emit(GetPopularMovieSuccessState());
    }).catchError((e) {
      print(e);
      emit(GetPopularMovieErrorState());
    });
  }
}
