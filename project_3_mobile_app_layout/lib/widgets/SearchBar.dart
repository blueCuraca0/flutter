import 'package:flutter/material.dart';
import '../CColors.dart';

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
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        child: Container(
          padding: const EdgeInsets.all(1),
          color: CColors.item,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(14)),
            child: Container(
              padding: const EdgeInsets.all(15),
              color: CColors.background,
              child: const Row(
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
          ),
        ),
      ),
    );
  }
}
