import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies_app/screens/browse_screen/browse_screen.dart';
import 'package:movies_app/screens/home_secreen/home_screen.dart';
import 'package:movies_app/screens/search_screen/search_screen.dart';
import 'package:movies_app/screens/watch_list_screen/watch_list_screen.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({Key? key}) : super(key: key);

  static const String routeName = 'main layout';

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  List<Widget> screens = [
    const HomeScreen(),
    const SearchScreen(),
    const BrowseScreen(),
    const WatchListScreen(),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.light.copyWith(
        statusBarColor: const Color(0xff1A1A1A),
        systemNavigationBarColor: const Color(0xff1A1A1A),
      ),
    );
    return Scaffold(
      backgroundColor: const Color(0xff1A1A1A),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          currentIndex = index;
          setState(() {});
        },
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xff1A1A1A),
        selectedItemColor: const Color(0xffFFBB3B),
        unselectedItemColor: const Color(0xffC6C6C6),
        iconSize: 20,
        selectedLabelStyle: const TextStyle(fontSize: 10),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        items: const [
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(FontAwesomeIcons.houseChimney),
              ),
              label: 'HOME'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(FontAwesomeIcons.magnifyingGlass),
              ),
              label: 'SEARCH'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(FontAwesomeIcons.clapperboard),
              ),
              label: 'BROWSE'),
          BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.all(4.0),
                child: Icon(FontAwesomeIcons.bookBookmark),
              ),
              label: 'WATCHLIST'),
        ],
      ),
      body: SafeArea(child: screens[currentIndex]),
    );
  }
}
