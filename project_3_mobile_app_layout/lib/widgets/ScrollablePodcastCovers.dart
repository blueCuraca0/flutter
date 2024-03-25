import 'package:flutter/material.dart';

class ScrollablePodcastCovers extends StatelessWidget {
  final Widget _upperPannel;
  final Map<String, String> _podcasts;

  const ScrollablePodcastCovers(this._upperPannel, this._podcasts, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          _upperPannel,
          SizedBox(
              height: 85,
              child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _podcasts.length + 2,
                  itemBuilder: (context, index) {
                    if (index == 0 || index == _podcasts.length + 1) {
                      return const SizedBox(width: 10,);
                    }
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(_podcasts.values.elementAt(index - 1))
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(width: 10,)
              )
          )
        ],
      ),
    );
  }
}
