import 'package:flutter/material.dart';
import 'package:catalogo_de_videos/components/posters_display.dart';
import 'package:catalogo_de_videos/components/search_field.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import '../model/video.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoController controller;
  List<Video> movies = [];
  bool loaded = false;

  _HomePageState() {
    controller = VideoController();
  }

  @override
  void initState() {
    super.initState();
    getFilmes();
  }

  void getFilmes() async {
    movies = await controller.getMovies();
    loaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Home"), backgroundColor: ThemeColors.appBar),
        backgroundColor: ThemeColors.background,
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: loaded
            ? Column(
                children: [
                  SearchField(),
                  movies.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Center(
                              child: Text(
                            "Nenhum filme encontrado!",
                            style: TextStyle(color: ThemeColors.text),
                          )))
                      : PostersDisplay(
                          title: "Filmes",
                          children: (movies.map((video) => VideoCard(
                                name: video.name,
                                url: video.thumbnailImageId,
                              ))).toList())
                ],
              )
            : const Center(child: CircularProgressIndicator()));
  }
}
