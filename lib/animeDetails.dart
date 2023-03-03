import 'package:flutter/material.dart';

class AnimeDetails extends StatelessWidget{
  const AnimeDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text('Animes')),
      body: Center(),
    );
  }
}