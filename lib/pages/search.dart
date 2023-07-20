import 'package:catalogo_de_videos/components/bottom_navigator.dart';
import 'package:catalogo_de_videos/components/posters_display.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/pages/video_details.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

const List<String> generos = [
  "",
  "Comedia",
  "Terror",
  "Aventura",
  "Suspense",
  "Ação"
];

const List<String> tipoDeVideo = [
  "",
  "Filme",
  "Serie",
];

class SearchScreen extends StatefulWidget {
  static String routename = '/search';
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late VideoController controller;
  String generoEscolhido = generos.first;
  String tipoDeVideoEscolhido = tipoDeVideo.first;
  List<Video> videos = [];
  bool loaded = false;

  _SearchScreenState() {
    controller = VideoController();
  }

  _search() async {
    videos = [];
    if (tipoDeVideoEscolhido == "" || generoEscolhido == "") return;
    int type = tipoDeVideoEscolhido == 'Filme' ? 0 : 1;
    videos = await controller.getVideosByFilters(type, generoEscolhido);
    loaded = true;
    setState(() {});
  }

  void onTap(int id) async {
    Video video = await controller.getVideoById(id);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoDetailsScreen(
                  video: video,
                ))).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Vídeos"),
          centerTitle: true,
          backgroundColor: ThemeColors.dark),
      backgroundColor: ThemeColors.background,
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton<String>(
                  value: generoEscolhido,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? value) {
                    loaded = false;
                    // This is called when the user selects an item.
                    setState(() {
                      generoEscolhido = value!;
                    });
                  },
                  items: generos.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                DropdownButton<String>(
                  value: tipoDeVideoEscolhido,
                  style: const TextStyle(color: Colors.deepPurple),
                  onChanged: (String? value) {
                    // This is called when the user selects an item.
                    setState(() {
                      loaded = false;
                      tipoDeVideoEscolhido = value!;
                    });
                  },
                  items:
                      tipoDeVideo.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                    onPressed: _search, child: const Icon(Icons.search)),
              ],
            ),
            loaded
                ? SingleChildScrollView(
                    child: Column(
                        children: videos
                            .map((video) => VideoCard(
                                name: video.name,
                                url: video.thumbnailImageId,
                                onTap: () => onTap(video.id!)))
                            .toList()))
                : Container(),
          ])),
      bottomNavigationBar: const BottomNavigationBarWidget(index: 1),
    );
  }
}
