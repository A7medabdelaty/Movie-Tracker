import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/cubit/cubit_states.dart';

import '../models/movie_model.dart';
import '../shared/network/local/database_utils.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(InitMoviesState());

  static MovieCubit get(context) => BlocProvider.of(context);

  List<Results> watchList = [];

  void getWatchListMovies() {
    emit(GetWatchListLoadingState());
    DataBaseUtils.getWatchList().then((value) {
      watchList = value.docs.map((e) {
        e.data().inWatchList = true;
        return e.data();
      }).toList();
      emit(GetWatchListSuccessState());
    }).catchError((e) {
      print(e);
      emit(GetWatchListErrorState());
    });
  }

  void onBookMarkTab(Results movie) {
    for (var element in watchList) {
      if (element.id == movie.id) {
        movie.inWatchList = false;
        return removeMovieFromWatchList(movie);
      }
    }
    movie.inWatchList = true;
    return addMovieToWatchList(movie);
  }

  void addMovieToWatchList(Results movie) {
    emit(AddMovieToWatchListLoadingState());
    DataBaseUtils.addMovieToFireStore(movie).then((value) {
      emit(AddMovieToWatchListSuccessState());
      getWatchListMovies();
    }).catchError((e) {
      emit(AddMovieToWatchListErrorState());
      print(e);
    });
  }

  void removeMovieFromWatchList(Results movie) {
    emit(RemoveMovieFromWatchListLoadingState());
    DataBaseUtils.removeMovieFromFireStore(movie).then((value) {
      emit(RemoveMovieFromWatchListSuccessState());
      getWatchListMovies();
    }).catchError((e) {
      emit(RemoveMovieFromWatchListErrorState());
      print(e);
    });
  }
}
