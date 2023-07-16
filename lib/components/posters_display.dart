import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:flutter/material.dart';

class PostersDisplay extends StatelessWidget {
  List<VideoCard> children = const <VideoCard>[];
  late String title;
  PostersDisplay({required this.title, required this.children, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                )),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: children,
              ),
            )
          ],
        ));
  }
}
