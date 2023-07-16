import 'package:flutter/material.dart';
import '../styles/theme_colors.dart';

class VideoCard extends StatelessWidget {
  late String url;
  late String name;
  late double cardWidth;
  VideoCard({required this.name, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    cardWidth = (screenWidth - 50) / 2.5;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
            onTap: () => {print(name)},
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.network(
                    url,
                    height: cardWidth * 1.5,
                    width: cardWidth,
                  )),
              Text(
                name,
                style: TextStyle(color: ThemeColors.text, fontSize: 15),
              )
            ])));
  }
}
