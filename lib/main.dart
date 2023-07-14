import 'package:flutter/material.dart';

import 'pages/login.dart';

final routes = {
  '/': (BuildContext context) => const LoginPage(),
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
