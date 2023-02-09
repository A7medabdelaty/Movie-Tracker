import 'package:bloc/bloc.dart';
import 'package:movies_app/cubit/cubit_states.dart';

class MovieCubit extends Cubit<MovieStates> {
  MovieCubit() : super(InitMoviesState());
}
