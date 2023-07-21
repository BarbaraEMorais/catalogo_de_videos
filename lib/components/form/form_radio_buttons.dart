import 'dart:ui';

import 'package:catalogo_de_videos/styles/theme_colors.dart';
import 'package:flutter/material.dart';

class FormRadioButtons extends StatefulWidget {
  final void Function(int) onChanged;
  final int type;
  const FormRadioButtons({super.key, required this.onChanged, this.type = 0});

  @override
  State<FormRadioButtons> createState() => _FormRadioButtonState();
}

class _FormRadioButtonState extends State<FormRadioButtons> {
  late int _type;
  @override
  void initState() {
    _type = widget.type;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: ListTile(
          horizontalTitleGap: 0,
          title: Text(
            'Filme',
            style: TextStyle(color: ThemeColors.formInput),
          ),
          leading: Radio<int>(
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return ThemeColors.formInput; // defer to the defaults
            }),
            value: 0,
            groupValue: _type,
            onChanged: (int? value) {
              setState(() {
                _type = value!;
              });
              widget.onChanged(value!);
            },
          ),
        )),
        Expanded(
            child: ListTile(
          horizontalTitleGap: 0,
          title: Text(
            'Serie',
            style: TextStyle(color: ThemeColors.formInput),
          ),
          leading: Radio<int>(
            value: 1,
            fillColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
              return ThemeColors.formInput; // defer to the defaults
            }),
            groupValue: _type,
            onChanged: (int? value) {
              setState(() {
                _type = value!;
              });
              widget.onChanged(value!);
            },
          ),
        )),
      ],
    );
  }
}
