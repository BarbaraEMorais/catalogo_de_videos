import 'package:catalogo_de_videos/pages/add_video.dart';
import 'package:catalogo_de_videos/pages/cadastro.dart';
import 'package:catalogo_de_videos/pages/home.dart';
import 'package:flutter/material.dart';

import 'pages/login.dart';

final routes = {
  HomePage.routeName:(BuildContext context) => const HomePage(),
  LoginPage.routeName: (BuildContext context) => const LoginPage(),
  CadastroPage.routeName: (BuildContext context) => const CadastroPage(),
  AddVideo.routeName: (BuildContext context) => const AddVideo(),
};

void main() {
  runApp(MaterialApp(
    title: "Login",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal),
    routes: routes,
  ));
}
