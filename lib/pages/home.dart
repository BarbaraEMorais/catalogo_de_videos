import 'package:catalogo_de_videos/components/posters_display.dart';
import 'package:catalogo_de_videos/components/video_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Home")),
        body: Column(
          children: [
            PostersDisplay(title: "Filmes", children: [
              VideoCard(
                name: "A casa monstro",
                url:
                    "https://mir-s3-cdn-cf.behance.net/project_modules/max_1200/61da8438155793.57575971afe13.jpg",
              ),
              VideoCard(
                name: "Avatar",
                url:
                    "http://3.bp.blogspot.com/-H57vRpipBhs/T92h_GLMFAI/AAAAAAAAAAc/zLYxoSfXv9w/s1600/avatar_movie_poster_final_01.jpg",
              ),
              VideoCard(
                name: "Piratas do Caribe",
                url:
                    "http://images2.fanpop.com/images/photos/8400000/Movie-Posters-movies-8405245-1224-1773.jpg",
              ),
              VideoCard(
                name: "Liga da Justiça",
                url:
                    "https://www.slashfilm.com/wp/wp-content/images/2017-bestposter-justiceleague.jpg",
              ),
            ])
          ],
        ));
  }
}
