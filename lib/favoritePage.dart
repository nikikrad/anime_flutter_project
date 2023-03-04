import 'package:anime_flutter_project/apiService.dart';
import 'package:anime_flutter_project/searchPage.dart';
import 'package:flutter/material.dart';

import 'animeDetails.dart';
import 'homePage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePage createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 2;

    void _onItemTapped(int index) {
      setState(() {
        openBottomNavigationPage(context, index);
      });
    }

    Widget customSearchBar = const Text('Favorite Anime');
    return Scaffold(
      appBar: AppBar(
        title: customSearchBar,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }

  openPage(context, Data data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AnimeDetails(data: data)));
  }

  openAnimeDetailsPage(context, Data data) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => AnimeDetails(data: data)));
  }

  openBottomNavigationPage(context, int page) {
    if (page == 1) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SearchPage()));
    } else if (page == 2) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const FavoritePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }
}
