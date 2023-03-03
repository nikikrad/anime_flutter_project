import 'package:anime_flutter_project/apiService.dart';
import 'package:flutter/material.dart';

import 'animeDetails.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key){
    loadAnime();
  }

  loadAnime() async{
    final results = await AnimeService().getAnime();
    print(results.data![0].attributes?.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Animes')),
      body: const Center(),
      // ListView.builder(
      //   itemCount: ,
      //   itemBuilder: (context, index){
      //     final
      //     return ListTile(
      //     title: Text(),
      //     subtitle: Text(),
      //     onTap: () => openPage(context),
      //     trailing: const Icon(Icons.chevron_right_outlined),
      //     )

      // ),
    );
  }

  openPage(context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AnimeDetails()));
  }
}
