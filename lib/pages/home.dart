import 'package:catalogo_de_videos/components/posters_display.dart';
import 'package:catalogo_de_videos/components/search_field.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

import 'package:catalogo_de_videos/controller/video_controller.dart';

import '../model/video.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late VideoController controller;
  List<Video> videos = [];

  // ou seja, instancia o controller se a pagina for chamada
  _HomePageState() {
    controller = VideoController();
  }

  @override
  void initState() {
    getVideos();
  }

  void getVideos() async {
    videos = await controller.getVideos();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        backgroundColor: ThemeColors.background,
        body: Column(
          children: [
            SearchField(),
            PostersDisplay(
                title: "Filmes",
                // children: [],
                children: videos.isEmpty
                    ? [
                        VideoCard(
                            name: "name",
                            url:
                                "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/61da8438155793.57575971afe13.jpg")
                      ]
                    : (videos.map((video) => VideoCard(
                          name: video.name,
                          url: video.thumbnailImageId,
                        ))).toList())
          ],
        ));
  }
}
