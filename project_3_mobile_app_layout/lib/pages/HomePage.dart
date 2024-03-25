import 'package:flutter/material.dart';
import 'package:project_3_mobile_app_layout/widgets/ScrollablePodcastCovers.dart';
import '../widgets/EpisodeTile.dart';

class HomePage extends StatelessWidget {
  final List<EpisodeTile> _episodes;
  final Map<String, String> _podcasts;
  static final Widget _upperPannel = Container(
    padding: const EdgeInsets.all(20),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Subscriptions", style: TextStyle(fontWeight: FontWeight.w500),),
        Text("More", style: TextStyle(color: Colors.grey),)
      ],
    ),
  );
  late ScrollablePodcastCovers _scrollablePodcastCovers;

  HomePage(this._podcasts, this._episodes, {super.key}) {
    _scrollablePodcastCovers = ScrollablePodcastCovers(_upperPannel, _podcasts);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _scrollablePodcastCovers,
        ..._episodes,
      ],
    );
  }


}
