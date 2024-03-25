import 'package:flutter/material.dart';

import '../CColors.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LibraryTile(icon: Icon(Icons.subscriptions_outlined,), section: "Subscriptions"),
        LibraryTile(icon: Icon(Icons.playlist_add,), section: "Queue"),
        LibraryTile(icon: Icon(Icons.download_for_offline_outlined,), section: "Download"),
        LibraryTile(icon: Icon(Icons.history,), section: "History"),
      ],
    );
  }
}

class LibraryTile extends StatelessWidget {
  final Icon icon;
  final String section;

  const LibraryTile({super.key, required this.icon, required this.section});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: CColors.divider
        )
      ),
      child: Row(
        children: [
          icon,
          const SizedBox(width: 15,),
          Expanded(child: Text(section, style: const TextStyle(fontSize: 18))),
          const Icon(Icons.keyboard_arrow_right),
        ],
      ),
    );
  }
}