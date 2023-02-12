import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/base.dart';
import 'package:movies_app/cubit/cubit_states.dart';
import 'package:movies_app/models/CategoryModel.dart';
import 'package:movies_app/screens/browse_screen/browse_navigator.dart';
import 'package:movies_app/screens/browse_screen/browse_view_model.dart';
import 'package:movies_app/screens/browse_screen/movies_list_screen.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({Key? key}) : super(key: key);

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends BaseView<BrowseScreen, BrowseViewModel>
    implements BrowseNavigator {
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BrowseViewModel, MovieStates>(
      listener: (context, state) {},
      builder: (context, state) {
        BrowseViewModel cubit = BrowseViewModel.get(context);
        return Container(
          padding: const EdgeInsets.only(left: 17, right: 17, top: 30),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Browse Category',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ConditionalBuilder(
                condition: cubit.categories.isNotEmpty,
                builder: (context) => Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 9 / 5,
                            crossAxisCount: 2,
                            mainAxisSpacing: 15,
                            crossAxisSpacing: 15),
                    itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          cubit.getMoviesByGenres(cubit.categories[index]);
                          Navigator.pushNamed(
                            context,
                            BrowseMovies.routeName,
                            arguments: cubit.categories[index]
                          );
                        },
                        child: categoryCard(cubit.categories[index])),
                    itemCount: cubit.categories.length,
                  ),
                ),
                fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget categoryCard(Genres category) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/category image.png',
            fit: BoxFit.cover,
          ),
          Text(
            '${category.name}',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }

  @override
  BrowseViewModel initViewModel() {
    return BrowseViewModel();
  }
}
