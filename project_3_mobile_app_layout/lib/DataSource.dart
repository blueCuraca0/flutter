import 'dart:ui';
import 'episode.dart';

class DataSource {
  DataSource._privateConstructor();
  static final DataSource _instance = DataSource._privateConstructor();
  factory DataSource() => _instance;

  final Color bgColor = const Color(0xfffdf9f6);
  final Color accentColor = const Color(0xfff2f1ed);

  final Map<String, String> _podcasts = const {
    'Буде тобі наука': 'lib/podcast_covers/bude_tobi_nauka.jpg',
    'Hacking your ADHD': 'lib/podcast_covers/hacking_your_adhd.jpg',
    'So cultured': 'lib/podcast_covers/so_cultured.jpg',
    'Android Story': 'lib/podcast_covers/android_story.jpg',
    'TED Talks Daily': 'lib/podcast_covers/ted_talks_daily.jpg',
    'Today, explained': 'lib/podcast_covers/today_explained.jpg',
  };

  final List<Episode> _episodes = [
    Episode(
      // imagePath: _podcasts['Буде тобі наука']!,
      imagePath: 'lib/podcast_covers/bude_tobi_nauka.jpg',
      podcastName: 'Буде тобі наука',
      topic: 'Чому відкриття виду Homo naledi перевернуло еволюцію людини з ніг на голову?',
      description: 'У 2013 році два відчайдухи Стівен Такер та Рік Гантер вирішили залізти до печери з красивою назвою «Висхідна Зоря» у Південній Африці. Там вони знайшли й зафільмували багацько кісток. З часом виявилось, що вони належать новому виду роду Homo, що отримали назву Homo naledi. Звідки взялася ця назва та що нам відомо про Homo naledi?'
    ),
    Episode(
      imagePath: 'lib/podcast_covers/hacking_your_adhd.jpg',
      podcastName: 'Hacking your ADHD',
      topic: 'At the Root of ADHD: Trauma vs Genetics',
      description: "In today’s episode, we have a listener question dealing with the root cause of ADHD and whether or not ADHD comes from trauma or it's something we're born with.",
      timeSincePosted: '2 hours ago',
    ),
    Episode(
      imagePath: 'lib/podcast_covers/so_cultured.jpg',
      podcastName: 'So cultured',
      topic: 'A new upgrade for humans? + Your fav influencer is a catfish!',
      description: 'Welcome to the debut episode of the So Cultured Podcast! ?️ in todays episode Taz will explore the mind-bending possibility of humans having their own software upgrades, through unlocking the new capabilities of gene editing!',
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
      topic: '3 mysteries of the universe - and a new force that might explain them | Alex Keshavarski',
      description: "We're still in the dark about what 95 percent of our universe is made of — and the standard model for understanding particle physics has hit a limit. What's the next step forward? Particle physicist Alex Keshavarzi digs into the first results of the Muon g-2 experiment at Fermilab in Chicago, which found compelling evidence of new particles or forces existing in our universe — a finding that could act as a window into the subatomic world and deepen our understanding of the fabric of reality.",
      timeSincePosted: '1 year ago',
    ),
    Episode(
      imagePath: 'lib/podcast_covers/today_explained.jpg',
      podcastName: 'Today, explained',
      topic: 'Bringing back the SAT',
      description: 'Four years after a pandemic pause, some colleges and universities are again requiring applicants to submit standardized test scores. Inside Higher Ed’s Liam Knox and the University of Delaware’s Dominique Baker explain.This episode was produced by Avishay Artsy, edited by Matt Collette, fact-checked by Laura Bullard, engineered by Rob Byers, and guest-hosted by Jonquilyn Hill.',
      timeSincePosted: '2 months ago',
    ),
  ];

  get episodes => _episodes;
  get podcasts => _podcasts;
}