import 'package:flutter/material.dart';

import 'apiService.dart';

class AnimeDetails extends StatelessWidget{
  final Data data;
  const AnimeDetails({Key? key, required this.data});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Animes')),
      body: Center(),
    );
  }
}