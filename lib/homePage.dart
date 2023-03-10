import 'package:anime_flutter_project/apiService.dart';
import 'package:anime_flutter_project/searchPage.dart';
import 'package:flutter/material.dart';

import 'animeDetails.dart';
import 'favoritePage.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Data>?> futureData;

  @override
  void initState() {
    super.initState();
    futureData = AnimeService().getAnime();
  }

  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;

    void _onItemTapped(int index) {
      setState(() {
        _currentIndex = index;
        openBottomNavigationPage(context, index);
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anime'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          var data = await AnimeService().getAnime();
          setState(() {
            futureData = Future.value(data);
          });
        },
        child: Center(
            child: FutureBuilder<List<Data>?>(
          future: futureData,
          builder: ((context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  Data data = snapshot.data![index];
                  return Semantics(
                    child: ListTile(
                      title:
                          Text(data.attributes!.titles!.enJp ?? 'Нет данных'),
                      // data.attributes!.titles!.enJp! != null &&
                      //         data.attributes!.titles!.enJp!.isNotEmpty
                      //     ? Text(data.attributes!.titles!.enJp!)
                      //     : const Text("Нет данных"),
                      subtitle: (Text(data.attributes!.averageRating ?? '76.32')),
                      // data.attributes!.averageRating! != null &&
                      //           data.attributes!.averageRating!.isNotEmpty
                      //       ? Text(data.attributes!.averageRating!)
                      //       : const Text("Нет данных"),
                      leading: data.attributes!.posterImage!.large != null &&
                              data.attributes!.posterImage!.large!.isNotEmpty
                          ? Image.network(
                              data.attributes!.posterImage!.large!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey,
                            ),
                      trailing: const Icon(Icons.chevron_right_outlined),
                      onTap: () => openAnimeDetailsPage(context, data),
                      iconColor: Colors.brown,
                    ),
                  );
                },
                itemCount: snapshot.data!.length,
              );
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
