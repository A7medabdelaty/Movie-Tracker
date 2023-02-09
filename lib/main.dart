import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/bloc_observer.dart';
import 'package:movies_app/layout/main_layout.dart';
import 'package:movies_app/screens/browse_screen/browse_view_model.dart';
import 'package:movies_app/screens/home_secreen/home_view_model.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_screen.dart';
import 'package:movies_app/screens/movie_details_screen/movie_details_view_model.dart';
import 'package:movies_app/screens/search_screen/search_screen_view_model.dart';
import 'package:movies_app/shared/network/remote/dio.dart';

import 'firebase_options.dart';

void main() async {
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeViewModel()
            ..getRecommendedMovies()
            ..getPopularMovies()
            ..getNewReleaseMovies(),
        ),
        BlocProvider(
          create: (context) => SearchViewModel(),
        ),
        BlocProvider(
          create: (context) => BrowseViewModel()..getCategories(),
        ),
        BlocProvider(
          create: (context) => MovieDetailsViewModel(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true),
      routes: {
        MainLayout.routeName: (context) => const MainLayout(),
        MovieDetailsScreen.routeName: (context) => const MovieDetailsScreen()
      },
      initialRoute: MainLayout.routeName,
    );
  }
}
