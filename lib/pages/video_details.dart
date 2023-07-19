import 'package:catalogo_de_videos/components/form/form_alert.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class VideoDetailsScreen extends StatelessWidget {
  static String routeName = '/video_details';
  final Video video;
  const VideoDetailsScreen({super.key, required this.video});

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
                child: Column(children: [
                  VideoCard(
                      name: video.name,
                      url: video.thumbnailImageId,
                      scale: 1.5),
                  Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: Text(
                        video.description,
                        style: TextStyle(color: ThemeColors.text),
                      )),
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
                                await VideoController().deleteVideo(video);
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
