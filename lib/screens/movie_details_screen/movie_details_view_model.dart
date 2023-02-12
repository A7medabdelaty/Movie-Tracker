import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/shared/constants.dart';
import 'package:movies_app/shared/network/remote/dio.dart';

import '../../models/MovieDetailsModel.dart';

class MovieDetailsViewModel extends BaseViewModel {
  static MovieDetailsViewModel get(context) => BlocProvider.of(context);

  Future<MovieDetailsModel> getMovieDetails(int movieId) {
    emit(GetMovieDetailsLoadingState());
    return DioHelper.getData(url: 'movie/$movieId', query: {'api_key': API_KEY})
        .then((value) {
      emit(GetMovieDetailsSuccessState());
      return MovieDetailsModel.fromJson(value?.data);
    }).catchError((e) {
      emit(GetMovieDetailsErrorState());
      print(e);
    });
  }

  List<Results> similarMovies = [];

  void getSimilarMovies(int movieId) {
    emit(GetSimilarMoviesLoadingState());
    DioHelper.getData(
        url: 'movie/$movieId/similar',
        query: {'api_key': API_KEY}).then((value) {
      similarMovies = MovieModel.fromJson(value?.data).results!;
      print(similarMovies[1].id);
      emit(GetSimilarMoviesSuccessState());
    }).catchError((e) {
      emit(GetSimilarMoviesErrorState());
      print(e);
    });
  }
}
