import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class BottomNavigatorBarWidget extends StatelessWidget {
  final int index;
  const BottomNavigatorBarWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
      currentIndex: index,
      selectedItemColor: ThemeColors.purple,
      unselectedItemColor: ThemeColors.grey,
      // onTap: 1,
    );
  }
}
