import 'package:catalogo_de_videos/components/form/form_input.dart';
import 'package:catalogo_de_videos/components/form/form_radio_buttons.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/model/video_genre.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

import 'package:catalogo_de_videos/model/genre.dart';

const List<String> genres = [
  'Comedia',
  'Terror',
  'Aventura',
  'Suspense',
  'Ação'
];

class EditVideo extends StatefulWidget {
  static String routeName = "/edit_video";
  Video video;
  Genre genre;
  EditVideo({super.key, required this.video, required this.genre});

  @override
  State<EditVideo> createState() => _EditVideoState();
}

class _EditVideoState extends State<EditVideo> {
  late String name;
  late String url;
  late String description;
  late String ageRestriction;
  late int duration;
  late String releaseDate;
  late int type;
  late String _genre;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    name = widget.video.name;
    url = widget.video.thumbnailImageId;
    description = widget.video.description;
    ageRestriction =
        widget.video.ageRestriction.replaceAll(new RegExp(r"\D"), "");
    duration = widget.video.durationMinutes;
    releaseDate = widget.video.releaseDate;
    type = widget.video.type;
    _genre = widget.genre.name;
  }

  void _edita() async {
    Video _video = Video(
        id: widget.video.id,
        name: name,
        description: description,
        type: type,
        ageRestriction: ageRestriction,
        durationMinutes: duration,
        releaseDate: releaseDate,
        thumbnailImageId: url,
        creatorid: widget.video.creatorid);

    int idGenre = -1;
    switch (_genre) {
      case 'Comedia':
        {
          idGenre = 1;
        }
      case 'Terror':
        {
          idGenre = 2;
        }
      case 'Aventura':
        {
          idGenre = 3;
        }
      case 'Suspense':
        {
          idGenre = 4;
        }
      case 'Ação':
        {
          idGenre = 5;
        }
    }

    VideoGenre video_genre = VideoGenre(videoid: _video.id!, genreid: idGenre);

    if (_formKey.currentState!.validate()) {
      int res = await VideoController().editVideo(_video, video_genre);
      //print(_video.toMap());
      Navigator.pop(context);
      String typeString = "Filme editado";
      if (type == 1) typeString = "Série editada";
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$typeString com sucesso')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Editar Vídeo"),
            backgroundColor: ThemeColors.appBar),
        backgroundColor: ThemeColors.background,
        body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Form(
                  key: _formKey,
                  child: Column(children: [
                    FormInput(
                      initialValue: name,
                      label: "Nome",
                      onChanged: (value) => {name = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira um nome!';
                        }
                        return null;
                      },
                    ),
                    FormInput(
                      initialValue: url,
                      label: "URL da imagem",
                      onChanged: (value) => {url = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira uma URL!';
                        } else if (!value.startsWith("http")) {
                          return 'Insira uma URL válida!';
                        }
                        return null;
                      },
                    ),
                    FormInput(
                      initialValue: description,
                      label: "Descrição",
                      maxLines: 3,
                      onChanged: (value) => {description = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira uma descrição!';
                        }
                        return null;
                      },
                    ),
                    FormInput(
                      initialValue: ageRestriction,
                      label: "Restrição de idade",
                      onChanged: (value) => {ageRestriction = "$value anos"},
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira uma idade mínima!';
                        } else if (int.parse(value) < 0 ||
                            int.parse(value) > 18) {
                          return 'Insira uma número entre 0(livre) e 18!';
                        }
                        return null;
                      },
                    ),
                    FormInput(
                      initialValue: duration.toString(),
                      label: "Duração (minutos)",
                      onChanged: (value) => {duration = int.parse(value)},
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira o tempo de duração!';
                        }
                        return null;
                      },
                    ),
                    FormInput(
                      initialValue: releaseDate,
                      label: "Data de Lançamento (dd/mm/aaaa)",
                      onChanged: (value) => {releaseDate = value},
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira uma data!';
                        }
                        return null;
                      },
                    ),
                    FormRadioButtons(
                      onChanged: (value) {
                        type = value;
                      },
                      type: type,
                    ),
                    DropdownButton<String>(
                      value: _genre,
                      style: const TextStyle(color: Colors.deepPurple),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          _genre = value!;
                        });
                      },
                      items:
                          genres.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )
                  ]),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: _edita,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return ThemeColors
                                  .formInput; // defer to the defaults
                            },
                          ),
                        ),
                        child: const Text("Editar")))
              ]),
        ));
  }
}
