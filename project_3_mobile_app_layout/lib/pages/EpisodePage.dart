import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../CColors.dart';
import '../Episode.dart';

class EpisodePage extends StatelessWidget {
  final Episode episode;

  const EpisodePage(this.episode, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CColors.background,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const SizedBox(
                height: 20,
              ),
              Hero(
                tag: episode.topic,
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.transparent,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(5, 5),
                            blurRadius: 7,
                          )
                        ]),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(episode.imagePath))),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                episode.topic,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(episode.description,
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
        ));
  }
}

/*

Text(
                episode.topic,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                episode.podcastName,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),

* */
