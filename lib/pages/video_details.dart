import 'package:catalogo_de_videos/components/form/form_alert.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:catalogo_de_videos/controller/genre_controller.dart';
import 'package:catalogo_de_videos/main.dart';
import 'package:catalogo_de_videos/model/user.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:catalogo_de_videos/helper/database_helper.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

import '../model/genre.dart';
import 'edit_video.dart';

class VideoDetailsScreen extends StatefulWidget {
  static String routeName = '/video_details';
  late Video video;
  VideoDetailsScreen({super.key, required this.video});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late VideoController videoController;
  late GenreController genreController;
  late List<Genre> generos;
  late User creator;
  bool loaded = false;
  DatabaseHelper con = DatabaseHelper();

  void getGenre() async {
    generos = await genreController.getGenreByVideo(widget.video);
    loaded = true;
    setState(() {});
  }

  void getVideo() async {
    widget.video = await videoController.getVideoById(widget.video.id!);
    loaded = true;
    setState(() {});
  }

  void getCreator() async {
    creator = await videoController.getCreator(widget.video);
    setState(() {});
  }

  _VideoDetailsScreenState() {
    genreController = GenreController();
    videoController = VideoController();
  }

  @override
  void initState() {
    super.initState();
    getGenre();
    getCreator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home"), backgroundColor: ThemeColors.appBar),
      backgroundColor: ThemeColors.background,
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          VideoCard(
                              name: widget.video.name,
                              url: widget.video.thumbnailImageId,
                              scale: 1.5),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Descrição: " + widget.video.description,
                                style: TextStyle(color: ThemeColors.text),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Classificação Indicativa: " +
                                    widget.video.ageRestriction,
                                style: TextStyle(color: ThemeColors.text),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Tempo: " +
                                    widget.video.durationMinutes.toString() +
                                    " minutos",
                                style: TextStyle(color: ThemeColors.text),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Text(
                                "Lançamento: " + widget.video.releaseDate,
                                style: TextStyle(color: ThemeColors.text),
                              )),
                          Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: loaded
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Text(
                                            "Gênero: ",
                                            style: TextStyle(
                                                color: ThemeColors.text),
                                          ),
                                          Row(
                                              children: generos
                                                  .map((genero) => Text(
                                                        "${genero.name} ",
                                                        style: TextStyle(
                                                            color: ThemeColors
                                                                .text),
                                                      ))
                                                  .toList()),
                                        ])
                                  : const Center(
                                      child: CircularProgressIndicator())),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: loaded && creator != null
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                          Text(
                                            "Criador: ",
                                            style: TextStyle(
                                                color: ThemeColors.text),
                                          ),
                                          Text(
                                            creator.name,
                                            style: TextStyle(
                                                color: ThemeColors.text),
                                          ),
                                        ])
                                  : const Center(
                                      child: CircularProgressIndicator())),
                        ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          child: const Text("Editar"),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditVideo(
                                          video: widget.video,
                                          genre: generos.first,
                                        ))).then((value) => setState(() {
                                  getVideo();
                                  getGenre();
                                }));
                          }),
                      ElevatedButton(
                        child: const Text("Excluir"),
                        onPressed: () => showDialog(
                            context: context,
                            builder: (BuildContext context) => FormAlert(
                                  title: "Tem certeza que deseja excluir?",
                                  onAccept: () async {
                                    await VideoController()
                                        .deleteVideo(widget.video);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Vídeo deletado com sucesso!')),
                                    );
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                )),
                      ),
                    ],
                  )
                ],
              )))),
    );
  }
}
