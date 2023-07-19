import 'package:flutter/material.dart';
import '../styles/theme_colors.dart';

class VideoCard extends StatelessWidget {
  final String url;
  final String name;
  final Function()? onTap;
  final double scale;
  const VideoCard(
      {required this.name,
      required this.url,
      this.onTap,
      this.scale = 1,
      super.key});

  @override
  Widget build(BuildContext context) {
    double cardWidth;
    double screenWidth = MediaQuery.of(context).size.width;
    cardWidth = ((screenWidth - 50) / 2.5) * scale;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
            onTap: onTap,
            child: Column(children: [
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: Image.network(
                    url,
                    height: cardWidth * 1.5,
                    width: cardWidth,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  )),
              Container(
                  margin: EdgeInsets.only(top: 2 * scale),
                  child: Text(
                    name,
                    style: TextStyle(
                        color: ThemeColors.text, fontSize: 15 * (0.8 * scale)),
                  ))
            ])));
  }
}
