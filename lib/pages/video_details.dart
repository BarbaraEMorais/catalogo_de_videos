import 'package:catalogo_de_videos/components/form/form_alert.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:catalogo_de_videos/controller/genre_controller.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

import '../model/genre.dart';

class VideoDetailsScreen extends StatefulWidget {
  static String routeName = '/video_details';
  late Video video;
  VideoDetailsScreen({super.key, required this.video});

  @override
  State<VideoDetailsScreen> createState() => _VideoDetailsScreenState();
}

class _VideoDetailsScreenState extends State<VideoDetailsScreen> {
  late GenreController genreController;
  late List<Genre> generos;
  bool loaded = false;

  void getGenre() async {
    generos = await genreController.getGenreByVideo(widget.video);
    loaded = true;
    setState(() {});
  }

  _VideoDetailsScreenState() {
    genreController = GenreController();
  }

  @override
  void initState() {
    super.initState();
    getGenre();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Home"), backgroundColor: ThemeColors.appBar),
      backgroundColor: ThemeColors.background,
      body: Padding(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                      Text(
                                        "Gêneros: ",
                                        style:
                                            TextStyle(color: ThemeColors.text),
                                      ),
                                      Row(
                                          children: generos
                                              .map((genero) => Text(
                                                    "${genero.name} ",
                                                    style: TextStyle(
                                                        color:
                                                            ThemeColors.text),
                                                  ))
                                              .toList()),
                                    ])
                              : const Center(
                                  child: CircularProgressIndicator())),
                    ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      child: const Text("Editar"), onPressed: () => {}),
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
                                      content:
                                          Text('Vídeo deletado com sucesso!')),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                            )),
                  ),
                ],
              )
            ],
          ))),
    );
  }
}
