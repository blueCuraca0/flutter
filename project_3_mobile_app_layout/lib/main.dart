import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:project_3_mobile_app_layout/episode.dart';

import 'DataSource.dart';

/*
1) Побудувати ієрархію віджетів. А саме: Container, Column, Row, Expanded
2) Продемонструвати стилізацію віджетів. А саме: колір, розмір, тінь, бекграунд
3) Побудувати коректне розміщення віджетів за допомогою crossAxisAlignment, mainAxisAlignment
4) На основі зазначених вище завдань створити імітацію верстки моб. застосунку
* */

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const double appBarHeight = 60;
  static const double navBarHeight = 90;

  @override
  Widget build(BuildContext context) {

    final DataSource dataSource = DataSource();
    final Color bgColor = dataSource.bgColor;
    final Color accentColor = dataSource.accentColor;
    final Map<String, String> podcasts = dataSource.podcasts;
    final List<Episode> episodes = dataSource.episodes;

    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: bgColor,
          systemNavigationBarColor: accentColor,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarIconBrightness: Brightness.dark,
        )
    );

    return MaterialApp(
      title: "Google Podcasts' Imitation",
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // BOTTOM LAYER (Subscriptions and Episodes)
              Column(
                children: [
                  const SizedBox(height: appBarHeight),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        // SUBSCRIPTIONS
                        Container(
                          color: bgColor,
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              // UPPER PANEL
                              Container(
                                // padding: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.all(20),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Subscriptions", style: TextStyle(fontWeight: FontWeight.w500),),
                                    Text("More", style: TextStyle(color: Colors.grey),)
                                  ],
                                ),
                              ),
          
                              // PODCAST COVERS
                              SizedBox(
                                  height: 85,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: podcasts.length + 2,
                                      itemBuilder: (context, index) {
                                        if (index == 0 || index == podcasts.length + 1) {
                                          return const SizedBox(width: 10,);
                                        }
                                        return ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: Image.asset(podcasts.values.elementAt(index - 1))
                                        );
                                      },
                                      separatorBuilder: (context, index) => const SizedBox(width: 10,)
                                  )
                              )
                            ],
                          ),
                        ),
                        // EPISODES
                        ...episodes,
                      ],
                    ),
                  ),
                  const SizedBox(height: navBarHeight),
                ],
              ),
          
              // TOP LAYER (AppBar and NavBar)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // AppBar
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: appBarHeight,
                    decoration: BoxDecoration(
                      color: bgColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          offset: const Offset(0, 0),
                          blurRadius: 10,
                        )
                      ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.connected_tv),
                          tooltip: 'Connect to TV',
                          onPressed: () {},
                        ),
                        const Text('Google Podcasts', style: TextStyle(fontSize: 20)),
                        IconButton(
                          icon: const Icon(Icons.account_circle),
                          tooltip: 'Account',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  // NavBar
                  Container(
                    alignment: Alignment.bottomCenter,
                    height: navBarHeight,
                    padding: const EdgeInsets.all(10),
                    color: accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.home_filled),
                                tooltip: 'Main Page',
                                onPressed: () {},
                              ),
                              const Text('Main Page')
                            ],
                          ),
                        ),
          
                        Expanded(
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.search),
                                tooltip: 'Search',
                                onPressed: () {},
                              ),
                              const Text('Search')
                            ],
                          ),
                        ),
          
                        Expanded(
                          child: Column(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.video_library_outlined),
                                tooltip: 'Library',
                                onPressed: () {},
                              ),
                              const Text('Library')
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}
