import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/screens/search_screen/search_card.dart';
import 'package:movies_app/screens/search_screen/search_screen_navigator.dart';
import 'package:movies_app/screens/search_screen/search_screen_view_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends BaseView<SearchScreen, SearchViewModel>
    implements SearchNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    searchController.clear();
    return BlocConsumer<SearchViewModel, MovieStates>(
      builder: (context, state) {
        SearchViewModel cubit = SearchViewModel.get(context);
        return Container(
          color: const Color(0xff1A1A1A),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  maxLines: 1,
                  controller: searchController,
                  keyboardType: TextInputType.name,
                  onChanged: (value) {
                    cubit.searchForMovies(searchController.text);
                  },
                  style: const TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    hintText: 'Search',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 7, horizontal: 15),
                    fillColor: const Color(0xff514F4F),
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ConditionalBuilder(
                    condition: cubit.searchList.isNotEmpty,
                    builder: (context) => ListView.separated(
                        itemBuilder: (context, index) =>
                            SearchCard(cubit.searchList[index]),
                        separatorBuilder: (context, index) => const Divider(),
                        itemCount: cubit.searchList.length),
                    fallback: (context) => Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.local_movies,
                            color: Color(0xffB5B4B4),
                            size: 100,
                          ),
                          Text(
                            'No Movies Found',
                            style: TextStyle(
                              color: Color(0xffB5B4B4),
                              fontSize: 13,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  @override
  SearchViewModel initViewModel() {
    return SearchViewModel();
  }
}
