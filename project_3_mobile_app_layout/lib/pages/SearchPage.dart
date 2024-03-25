import 'package:flutter/material.dart';
import '../widgets/EpisodeTile.dart';
import '../widgets/ScrollablePodcastCovers.dart';
import '../widgets/SearchBar.dart';

class SearchPage extends StatelessWidget {
  final List<EpisodeTile> _episodes;
  final Map<String, String> _podcasts;
  static const Widget _searchBar = MySearchBar();
  static final Widget _upperPannel = Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    alignment: Alignment.centerLeft,
    child: const Text("Popular", style: TextStyle(fontWeight: FontWeight.w500),),
  );

  const SearchPage(this._podcasts, this._episodes, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _searchBar,
        ScrollablePodcastCovers(_upperPannel, _podcasts),
        ..._episodes.reversed,
      ],
    );
  }
}