import 'package:catalogo_de_videos/components/bottom_navigator.dart';
import 'package:catalogo_de_videos/model/user.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  static String routename = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final User user;

  _signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      preferences.setInt("value", 0);
    });
  }

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? name = preferences.getString("username");
    String? email = preferences.getString("email");
    String? password = preferences.getString("password");

    setState(() {
      user = User(email: email!, name: name!, password: password!);
    });
  }

  @override
  void initState() {
    getPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Perfil"),
          centerTitle: true,
          backgroundColor: ThemeColors.dark),
      backgroundColor: ThemeColors.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(
            Icons.person_4,
            size: 200,
            color: ThemeColors.grey,
          ),
          Column(children: [
            Text(
              user.name,
              style: TextStyle(color: ThemeColors.text, fontSize: 26),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            Text(
              user.email,
              style: TextStyle(color: ThemeColors.text),
            ),
          ]),
          ElevatedButton(onPressed: _signOut, child: Text("Sair da conta"))
        ],
      )),
      bottomNavigationBar: const BottomNavigationBarWidget(index: 2),
    );
  }
}
