import 'package:flutter/material.dart';

class VideoCard extends StatelessWidget {
  late String url;
  late String name;
  VideoCard({required this.name, required this.url, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: GestureDetector(
            onTap: () => {print(name)},
            child: Column(children: [
              Image.network(
                url,
                height: 230,
                width: 155,
              ),
              Text(name)
            ])));
  }
}
