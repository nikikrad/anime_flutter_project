import 'dart:async';

import 'package:anime_flutter_project/apiService.dart';
import 'package:anime_flutter_project/firebaseData.dart';
import 'package:anime_flutter_project/searchPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'animeDetails.dart';
import 'homePage.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePage createState() => _FavoritePage();
}

class _FavoritePage extends State<FavoritePage> {
  late Future<List<AnimeFirebaseResponse>?> futureData;

  @override
  void initState() {
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    initFirebase();
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
      body: RefreshIndicator(
        onRefresh: () async {
          // var data = await reference.child('users').child('1').once();
          setState(() {});
        },
        child: Center(
            child: FutureBuilder<List<AnimeFirebaseResponse>?>(
          // future: futureData,
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
            } else if (snapshot.hasError) {
              return Text('ERROR: ${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
        )),
      ),
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
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const FavoritePage()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  initFirebase() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    final reference = FirebaseDatabase.instance.reference();
    var ids = await reference.child("anime").once();
    List<AnimeFirebaseResponse> tempList = [];
    ids.snapshot.children.forEach((element) {
      tempList.add(
          AnimeFirebaseResponse(
            date: element.child("date").value.toString(),
            image: element.child("image").value.toString(),
            name: element.child("name").value.toString(),
            rating: element.child("rating").value.toString(),
            youtube: element.child("youtube").value.toString(),
          )
      );
    });
  }
}
