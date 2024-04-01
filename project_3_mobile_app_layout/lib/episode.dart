import 'dart:math';

class Episode {
  static const String justPosted = "A few moments ago";
  static int counter = 0;

  late final int _index;
  late final int _duration;
  late final String _imagePath;
  late final String _podcastName;
  late final String _timeSincePosted;
  late final String _topic;
  late final String _description;
  bool isChecked = false;

  Episode(
      {required String imagePath,
      required String podcastName,
      required String topic,
      required String description,
      String timeSincePosted = justPosted}) {
    _index = counter++;
    _imagePath = imagePath;
    _podcastName = podcastName;
    _topic = topic;
    _description = description;
    _timeSincePosted = timeSincePosted;
    _duration = Random().nextInt(55) + 5; // [5, 60)
  }

  get index => _index;

  get imagePath => _imagePath;

  get podcastName => _podcastName;

  get timeSincePosted => _timeSincePosted;

  get topic => _topic;

  get description => _description;

  get duration => _duration;

}
