import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:project_3_mobile_app_layout/widgets/EpisodeTile.dart';
import 'package:project_3_mobile_app_layout/pages/HomePage.dart';
import 'package:project_3_mobile_app_layout/pages/LibraryPage.dart';
import 'package:project_3_mobile_app_layout/pages/SearchPage.dart';
import 'package:project_3_mobile_app_layout/widgets/Drawer.dart';
import 'package:project_3_mobile_app_layout/widgets/PlayPanel.dart';
import 'package:project_3_mobile_app_layout/windows/PopupAccountWindow.dart';
import 'CColors.dart';
import 'Episode.dart';

/*
+ Декомпонувати застосунок на Stateful та Stateless віджети
+ Реалізувати зміни стану
    - Приклад: при натисканні на кнопку (є в ListPoint)
- Продемонструвати підхід "підняття стану нагору" (lifting state up)
    - Приклад: кошик інтернет-магазину змінює свій стан (додає продукт) при натисканні на кнопку "Купити" на головному віджеті
*/

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: CColors.bottomNavBar,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return const MaterialApp(
      title: "Google Podcasts' Imitation",
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  static late final MyDrawer _drawer;
  static late final List<Widget> _pages;
  static late final List<Episode> _episodes;
  static late final List<EpisodeTile> _episodeTiles;
  static late final Map<String, String> _podcasts;

  static const PopupAccountWindow _popupAccountWindow = PopupAccountWindow();
  static const double _playPanelHeight =
      PlayPanel.headerHeight + PlayPanel.padding;
  static const double iconSize = 28;

  final controller = PageController(initialPage: 0);

  Episode? _currentPlayingEpisode;
  bool _isPopupAccountMenuOpened = false;
  int _currentIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _currentIndex = index;
      controller.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  Icon _getHomePageIcon() {
    if (_currentIndex == 0) {
      return const Icon(
        Icons.home_outlined,
        size: iconSize,
      );
    } else {
      return const Icon(
        Icons.home,
        size: iconSize,
      );
    }
  }

  void _setCurrentPlayingEpisode(Episode episode) {
    setState(() {
      _currentPlayingEpisode = episode;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _drawer = const MyDrawer();
    _podcasts = {
      'Буде тобі наука': 'lib/podcast_covers/bude_tobi_nauka.jpg',
      'Hacking your ADHD': 'lib/podcast_covers/hacking_your_adhd.jpg',
      'So cultured': 'lib/podcast_covers/so_cultured.jpg',
      'Android Story': 'lib/podcast_covers/android_story.jpg',
      'TED Talks Daily': 'lib/podcast_covers/ted_talks_daily.jpg',
      'Today, explained': 'lib/podcast_covers/today_explained.jpg',
    };
    _episodes = [
      Episode(
          imagePath: 'lib/podcast_covers/bude_tobi_nauka.jpg',
          podcastName: 'Буде тобі наука',
          topic:
              'Чому відкриття виду Homo naledi перевернуло еволюцію людини з ніг на голову?',
          description:
              'У 2013 році два відчайдухи Стівен Такер та Рік Гантер вирішили залізти до печери з красивою назвою «Висхідна Зоря» у Південній Африці. Там вони знайшли й зафільмували багацько кісток. З часом виявилось, що вони належать новому виду роду Homo, що отримали назву Homo naledi. Звідки взялася ця назва та що нам відомо про Homo naledi?'),
      Episode(
        imagePath: 'lib/podcast_covers/hacking_your_adhd.jpg',
        podcastName: 'Hacking your ADHD',
        topic: 'At the Root of ADHD: Trauma vs Genetics',
        description:
            "In today’s episode, we have a listener question dealing with the root cause of ADHD and whether or not ADHD comes from trauma or it's something we're born with.",
        timeSincePosted: '2 hours ago',
      ),
      Episode(
        imagePath: 'lib/podcast_covers/so_cultured.jpg',
        podcastName: 'So cultured',
        topic: 'A new upgrade for humans? + Your fav influencer is a catfish!',
        description:
            'Welcome to the debut episode of the So Cultured Podcast! ?️ in todays episode Taz will explore the mind-bending possibility of humans having their own software upgrades, through unlocking the new capabilities of gene editing!',
        timeSincePosted: "18 days ago",
      ),
      Episode(
        imagePath: 'lib/podcast_covers/android_story.jpg',
        podcastName: 'Android Story',
        topic: 'Розмова про SORA від OpenAI',
        description: 'Вирізка з patreon.',
        timeSincePosted: '8 minutes ago',
      ),
      Episode(
        imagePath: 'lib/podcast_covers/ted_talks_daily.jpg',
        podcastName: 'TED Talks Daily',
        topic:
            '3 mysteries of the universe - and a new force that might explain them | Alex Keshavarski',
        description:
            "We're still in the dark about what 95 percent of our universe is made of — and the standard model for understanding particle physics has hit a limit. What's the next step forward? Particle physicist Alex Keshavarzi digs into the first results of the Muon g-2 experiment at Fermilab in Chicago, which found compelling evidence of new particles or forces existing in our universe — a finding that could act as a window into the subatomic world and deepen our understanding of the fabric of reality.",
        timeSincePosted: '1 year ago',
      ),
      Episode(
        imagePath: 'lib/podcast_covers/today_explained.jpg',
        podcastName: 'Today, explained',
        topic: 'Bringing back the SAT',
        description:
            'Four years after a pandemic pause, some colleges and universities are again requiring applicants to submit standardized test scores. Inside Higher Ed’s Liam Knox and the University of Delaware’s Dominique Baker explain.This episode was produced by Avishay Artsy, edited by Matt Collette, fact-checked by Laura Bullard, engineered by Rob Byers, and guest-hosted by Jonquilyn Hill.',
        timeSincePosted: '2 months ago',
      ),
    ];
    _episodeTiles = List.generate(_episodes.length,
        (index) => EpisodeTile(_episodes[index], _setCurrentPlayingEpisode));
    _pages = [
      HomePage(_podcasts, _episodeTiles),
      SearchPage(_podcasts, _episodeTiles),
      const LibraryPage()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Google Podcast"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isPopupAccountMenuOpened = !_isPopupAccountMenuOpened;
                });
              },
              icon: const Icon(
                Icons.account_circle,
                size: iconSize,
              )
            ),
          ],
          backgroundColor: CColors.background,
          surfaceTintColor: CColors.background,
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.5),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: _currentPlayingEpisode == null
              ? const EdgeInsets.only(bottom: 0)
              : const EdgeInsets.only(bottom: _playPanelHeight),
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                var index = Random().nextInt(_episodes.length);
                _currentPlayingEpisode = _episodes[index];

                _episodes[index].isChecked = true;
                var currentTile = _episodeTiles[index];
                // print("${currentTile.episode.topic}");

                var state = currentTile.keyIsChecked.currentState;
                print("${currentTile.keyIsChecked}");

                state?.checkEpisode();
              });
            },
            backgroundColor: CColors.bottomNavBar,
            foregroundColor: CColors.item,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.shuffle,
              size: iconSize + 6,
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _navigateBottomBar,
          items: [
            BottomNavigationBarItem(icon: _getHomePageIcon(), label: "Home"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.search,
                  size: iconSize,
                ),
                label: "Search"),
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.video_library_outlined,
                  size: iconSize,
                ),
                label: "Library"),
          ],
          backgroundColor: CColors.bottomNavBar,
          selectedItemColor: Colors.black,
          unselectedItemColor: CColors.item,
        ),
        drawer: _drawer,
        backgroundColor: CColors.background,
        body: Stack(alignment: Alignment.bottomCenter, children: [
          PageView(
            controller: controller,
            onPageChanged: (page) {
              setState(() {
                _currentIndex = page;
              });
            },
            children: _pages,
          ),
          PlayPanel(_currentPlayingEpisode),
          _isPopupAccountMenuOpened ? _popupAccountWindow : const SizedBox(),
        ]));
  }
}
