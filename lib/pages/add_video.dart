import 'package:catalogo_de_videos/components/form/form_input.dart';
import 'package:catalogo_de_videos/components/form/form_radio_buttons.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class AddVideo extends StatefulWidget {
  static String routeName = "/add_video";
  const AddVideo({super.key});

  @override
  State<AddVideo> createState() => _AddVideoState();
}

class _AddVideoState extends State<AddVideo> {
  String name = '';
  String url = '';
  String description = '';
  String ageRestriction = '';
  int duration = 0;
  String releaseDate = '';
  int type = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Adicionar Vídeo"),
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
                    )
                  ]),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                        onPressed: () async {
                          Video video = Video(
                              name: name,
                              description: description,
                              type: type,
                              ageRestriction: ageRestriction,
                              durationMinutes: duration,
                              releaseDate: releaseDate,
                              thumbnailImageId: url);

                          if (_formKey.currentState!.validate()) {
                            int res = await VideoController().saveVideo(video);
                            Navigator.pop(context);
                            String typeString = "Filme adicionado";
                            if (type == 1) typeString = "Série adicionada";
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('$typeString com sucesso')),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color?>(
                            (Set<MaterialState> states) {
                              return ThemeColors
                                  .formInput; // defer to the defaults
                            },
                          ),
                        ),
                        child: const Text("Adicionar")))
              ]),
        ));
  }
}
