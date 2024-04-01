import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_3_mobile_app_layout/Episode.dart';

import '../CColors.dart';
import 'EpisodeTile.dart';

class PlayPanel extends StatefulWidget {
  static const double headerHeight = EpisodeTile.headerHeight;
  static const double padding = 10;
  static const playIcon = Icon(Icons.play_arrow_outlined);
  static const pauseIcon = Icon(Icons.pause);

  final Episode? episode;

  const PlayPanel(this.episode, {super.key});

  @override
  State<PlayPanel> createState() => _PlayPanelState();
}

class _PlayPanelState extends State<PlayPanel> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return widget.episode == null
        ? const SizedBox()
        : Container(
            height: PlayPanel.headerHeight + PlayPanel.padding * 2,
            width: double.infinity,
            padding: const EdgeInsets.all(PlayPanel.padding),
            color: CColors.playPanel,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    widget.episode!.imagePath,
                  ),
                ),
                const SizedBox(
                  width: PlayPanel.padding,
                ),
                Expanded(
                    child: Text(
                  widget.episode!.topic,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                )),
                const SizedBox(
                  width: PlayPanel.padding,
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                  icon: _isPlaying ? PlayPanel.pauseIcon : PlayPanel.playIcon,
                )
              ],
            ),
          );
  }
}
