import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/shared/constants.dart';

import '../../cubit/cubit_states.dart';
import '../../models/movie_model.dart';
import '../../shared/network/remote/dio.dart';

class SearchViewModel extends BaseViewModel {
  static SearchViewModel get(context) => BlocProvider.of(context);

  List<Results> searchList = [];

  void searchForMovies(String text) {
    if (text.isEmpty) {
      searchList = [];
      emit(EmptySearchListState());
      return;
    }
    emit(SearchForMovieLoadingState());
    DioHelper.getData(url: SEARCH_END_POINT, query: {
      'api_key': API_KEY,

      'query': text,
    }).then((value) {
      searchList = MovieModel.fromJson(value?.data).results!;
      emit(SearchForMovieSuccessState());
    }).catchError((e) {
      print(e);
      emit(SearchForMovieErrorState());
    });
  }
}
