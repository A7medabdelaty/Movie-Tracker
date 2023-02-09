abstract class MovieStates {}

class InitMoviesState extends MovieStates {}

class GetPopularMovieLoadingState extends MovieStates {}

class GetPopularMovieSuccessState extends MovieStates {}

class GetPopularMovieErrorState extends MovieStates {}

class GetNewReleaseMovieLoadingState extends MovieStates {}

class GetNewReleaseMovieSuccessState extends MovieStates {}

class GetNewReleaseMovieErrorState extends MovieStates {}

class GetRecommendedMovieLoadingState extends MovieStates {}

class GetRecommendedMovieSuccessState extends MovieStates {}

class GetRecommendedMovieErrorState extends MovieStates {}

class SearchForMovieLoadingState extends MovieStates {}

class SearchForMovieSuccessState extends MovieStates {}

class SearchForMovieErrorState extends MovieStates {}

class EmptySearchListState extends MovieStates {}

class GetCategoriesLoadingState extends MovieStates {}

class GetCategoriesSuccessState extends MovieStates {}

class GetCategoriesErrorState extends MovieStates {}

class GetMovieDetailsLoadingState extends MovieStates {}

class GetMovieDetailsSuccessState extends MovieStates {}

class GetMovieDetailsErrorState extends MovieStates {}

class GetSimilarMoviesLoadingState extends MovieStates {}

class GetSimilarMoviesSuccessState extends MovieStates {}

class GetSimilarMoviesErrorState extends MovieStates {}