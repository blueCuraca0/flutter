import 'package:flutter/material.dart';
import '../CColors.dart';
import '../widgets/EpisodeTile.dart';
import '../widgets/RoundedBorder.dart';
import '../widgets/ScrollablePodcastCovers.dart';

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

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(
          top: 20,
          bottom: 0,
          left: 20,
          right: 20
      ),
      child: const RoundedBorder(
        radius: 15,
        innerPadding: 15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
                flex: 1,
                child: Icon(Icons.search, color: CColors.item,)
            ),
            Expanded(
                flex: 7,
                child: Text("Input your search here...",
                  style: TextStyle(
                    color: CColors.item,
                    fontSize: 15,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
