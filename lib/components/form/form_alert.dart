import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class FormAlert extends StatelessWidget {
  final String title;
  final Function()? onAccept;
  const FormAlert({super.key, required this.title, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ThemeColors.alert,
      title: Text(
        title,
        style: TextStyle(fontSize: 18, color: ThemeColors.text),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Voltar'),
          child: const Text('Voltar'),
        ),
        TextButton(
          onPressed: onAccept,
          child: const Text('Sim'),
        ),
      ],
    );
  }
}
