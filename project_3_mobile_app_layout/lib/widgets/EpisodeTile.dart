import 'package:flutter/material.dart';
import 'package:project_3_mobile_app_layout/pages/EpisodePage.dart';
import 'package:project_3_mobile_app_layout/widgets/RoundedBorder.dart';
import '../CColors.dart';
import '../Episode.dart';

class EpisodeTile extends StatefulWidget {
  static const double headerHeight = 40;
  final Episode episode;
  final Function playEpisode;

  final keyIsChecked = GlobalKey<EpisodeTileState>();

  EpisodeTile(this.episode, this.playEpisode, {super.key});

  @override
  State<EpisodeTile> createState() => EpisodeTileState();

}

class EpisodeTileState extends State<EpisodeTile> {
  static const double headerHeight = EpisodeTile.headerHeight;
  static const double _shiftForUncheckedIcon = 8;
  static const double _padding = 20;
  bool isChecked = false;

  void checkEpisode() {
    setState(() {
      widget.episode.isChecked = true;
      isChecked = true;
      print("> ??????");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          top: _padding - _shiftForUncheckedIcon,
          bottom: _padding,
          left: _padding,
          right: _padding),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          border: Border(
            top: BorderSide(
              color: CColors.divider,
            ),
          )),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                splashColor: Colors.transparent,
                onTap: () {
                  setState(() {
                    widget.episode.isChecked = true;
                  });
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => EpisodePage(widget.episode)));
                },
                child: Column(
                  children: [
                    const SizedBox(height: _shiftForUncheckedIcon),
                    Row(
                      children: [
                        Hero(
                          tag: widget.episode.topic,
                          child: SizedBox(
                            height: headerHeight,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(7),
                              child: Image.asset(
                                widget.episode.imagePath,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.episode.podcastName),
                            Text(
                              widget.episode.timeSincePosted,
                              style: const TextStyle(color: Colors.grey),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      width: double.infinity,
                      child: Text(widget.episode.topic,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w500)),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Text(
                        widget.episode.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  RoundedBorder(
                    radius: 10,
                    innerPadding: 5,
                    child: InkWell(
                      onTap: () {
                        widget.playEpisode(widget.episode);
                      },
                      child: Row(
                        children: [
                          const Icon(Icons.play_circle_outline, color: CColors.item,),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 5,
                              right: 5
                            ),
                            child: Text(
                              "${widget.episode.duration} min",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: InkWell(
                      // splashColor: Colors.transparent,
                      onTap: () {},
                      child: const Icon(Icons.playlist_add, color: CColors.item,),
                    ),
                  ),
                  InkWell(
                    // splashColor: Colors.transparent,
                    onTap: () {},
                    child: const Icon(Icons.arrow_circle_down_sharp, color: CColors.item,),
                  ),
                  const Expanded(child: SizedBox()),
                  InkWell(
                    // splashColor: Colors.transparent,
                    onTap: () {},
                    child: const Icon(Icons.more_vert, color: CColors.item,),
                  ),
                ],
              ),
            ],
          ),
          widget.episode.isChecked
              ? const SizedBox()
              : UncheckedCircle(headerHeight, _shiftForUncheckedIcon),
        ],
      ),
    );
  }
}

class UncheckedCircle extends StatelessWidget {
  late final double _headerHeight;
  late final double _shiftForUncheckedIcon;

  UncheckedCircle(double headerHeight, double shiftForUncheckedIcon,
      {super.key}) {
    _headerHeight = headerHeight;
    _shiftForUncheckedIcon = shiftForUncheckedIcon;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: _headerHeight + _shiftForUncheckedIcon,
      width: _headerHeight + _shiftForUncheckedIcon,
      alignment: Alignment.topRight,
      child: const Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.circle, size: 18, color: CColors.background),
          Icon(Icons.circle, size: 13, color: Colors.red)
        ],
      ),
    );
  }
}
