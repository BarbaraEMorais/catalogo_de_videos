import 'package:catalogo_de_videos/model/video.dart';
import 'package:catalogo_de_videos/pages/add_video.dart';
import 'package:catalogo_de_videos/pages/cadastro.dart';
import 'package:catalogo_de_videos/pages/search.dart';
import 'package:catalogo_de_videos/pages/home.dart';
import 'package:catalogo_de_videos/pages/profile.dart';
import 'package:catalogo_de_videos/pages/video_details.dart';
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
  HomePage.routeName: (BuildContext context) => const HomePage(),
  LoginPage.routeName: (BuildContext context) => const LoginPage(),
  CadastroPage.routeName: (BuildContext context) => const CadastroPage(),
  AddVideo.routeName: (BuildContext context) => const AddVideo(),
  VideoDetailsScreen.routeName: (BuildContext context) =>
      VideoDetailsScreen(video: video),
  ProfileScreen.routename: (BuildContext context) => const ProfileScreen(),
  SearchScreen.routename: (BuildContext context) => const SearchScreen(),
};

void main() {
  runApp(MaterialApp(
    title: "Login",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal),
    routes: routes,
  ));
}
