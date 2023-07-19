import 'package:catalogo_de_videos/pages/search.dart';
import 'package:catalogo_de_videos/pages/home.dart';
import 'package:catalogo_de_videos/pages/profile.dart';
import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  final int index;
  const BottomNavigationBarWidget({super.key, required this.index});

  @override
  State<BottomNavigationBarWidget> createState() =>
      _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
  void _onItemTapped(int index) {
    if (index == widget.index) return;

    Widget route;
    switch (index) {
      case 0:
        route = const HomePage();
        break;
      case 1:
        route = const SearchScreen();
        break;
      case 2:
        route = const ProfileScreen();
        break;
      default:
        route = const HomePage();
    }
    setState(() {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(pageBuilder: (_, __, ___) => route),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: ThemeColors.dark,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Pesquisar',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle_rounded),
          label: 'Perfil',
        ),
      ],
      currentIndex: widget.index,
      onTap: _onItemTapped,
      selectedItemColor: ThemeColors.purple,
      unselectedItemColor: ThemeColors.grey,
    );
  }
}
