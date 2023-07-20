import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/pages/add_video.dart';
import 'package:catalogo_de_videos/pages/cadastro.dart';
import 'package:catalogo_de_videos/pages/home.dart';
import 'package:catalogo_de_videos/pages/video_details.dart';
import 'package:catalogo_de_videos/controller/video_controller.dart';
import 'package:flutter/material.dart';


import 'pages/login.dart';

final video = Video(
    name: '',
    description: '',
    type: 0,
    ageRestriction: '',
    durationMinutes: 0,
    releaseDate: '',
    thumbnailImageId: '');

final routes = {
  '/': (BuildContext context) => const HomePage(),
  //LoginPage.routeName: (BuildContext context) => const LoginPage(),
  //CadastroPage.routeName: (BuildContext context) => const CadastroPage(),
  AddVideo.routeName: (BuildContext context) => const AddVideo(),
  VideoDetailsScreen.routeName: (BuildContext context) =>
      VideoDetailsScreen(video: video),
};

void main() {

  runApp(MaterialApp(
    title: "Login",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal),
    routes: routes,
  ));
}
