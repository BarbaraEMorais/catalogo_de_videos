import 'package:catalogo_de_videos/pages/home.dart';
import 'package:flutter/material.dart';

import 'pages/login.dart';

final routes = {
  '/': (BuildContext context) => const HomePage(),
  '/login': (BuildContext context) => const LoginPage()
};

void main() {
  runApp(MaterialApp(
    title: "Login",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal),
    routes: routes,
  ));
}
