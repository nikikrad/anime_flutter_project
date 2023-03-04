import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'apiService.dart';

class AnimeDetails extends StatelessWidget {
  final Data data;

  AnimeDetails({Key? key, required this.data});

  @override
  Widget build(BuildContext context) {
    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: data.attributes?.youtubeVideoId ?? 'z-ENIHctNYM',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: Text(data.attributes?.titles?.enJp ??
              data.attributes?.titles?.jaJp ??
              data.attributes?.titles?.en ??
              "No data"),
        ),
        body: ListView(children: <Widget>[
          Image.network(data.attributes?.posterImage?.large ??
              "https://media.kitsu.io/anime/poster_images/11614/large.jpg"),
          Container(
            padding: const EdgeInsets.all(32.0),
            child: Row(
              children: [
                // First child in the Row for the name and the
                // Release date information.
                Expanded(
                  // Name and Release date are in the same column
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Code to create the view for name.
                      Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Original Name: ${data.attributes!.titles!.enJp ?? "No Data"}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Code to create the view for release date.
                      Text(
                        "Release Date: ${data.attributes?.startDate ?? "No Data"}",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                // Icon to indicate the rating.
                Icon(
                  Icons.star,
                  color: Colors.red[500],
                ),
                Text(data.attributes?.averageRating ?? "76.32"),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.only(
                  left: 32.0, top: 15.0, right: 20.0, bottom: 25.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Description",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      data.attributes?.description ?? "No Data",
                      style: const TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    )
                  ])),
          Expanded(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                playedColor: Colors.amber,
                handleColor: Colors.amberAccent,
              ),
              onReady: () {
                _controller.addListener(() {
                });
              },
            ),
          )
        ]));
  }
}
