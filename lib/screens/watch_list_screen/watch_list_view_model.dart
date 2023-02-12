import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';

class WatchListViewModel extends BaseViewModel {
  static WatchListViewModel get(context) => BlocProvider.of(context);
}
