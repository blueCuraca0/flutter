import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_3_mobile_app_layout/pages/EpisodePage.dart';
import '../CColors.dart';
import '../Episode.dart';

const double _headerHeight = 40;

class EpisodeTile extends StatelessWidget {

  final Episode episode;

  const EpisodeTile(this.episode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              color: CColors.divider,
            ),
          )
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => EpisodePage(episode)
              )
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: _headerHeight,
              child: Row(
                children: [
                  Hero(
                    tag: episode.imagePath,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(7),
                      child: Image.asset(episode.imagePath,),
                    ),
                  ),

                  const SizedBox(width: 10,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(episode.podcastName),
                      Text(episode.timeSincePosted, style: const TextStyle(
                        color: Colors.grey
                      ),)
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              episode.topic,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
            ),
            const SizedBox(height: 5,),
            Text(
              episode.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

}