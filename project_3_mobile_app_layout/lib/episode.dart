class Episode {
  late final String _imagePath;
  late final String _podcastName;
  late final String _timeSincePosted;
  late final String _topic;
  late final String _description;

  static const String justPosted = "A few moments ago";

  Episode({required String imagePath, required String podcastName,
    required String topic, required String description,
    String timeSincePosted = justPosted}) {
    _imagePath = imagePath;
    _podcastName = podcastName;
    _topic = topic;
    _description = description;
    _timeSincePosted = timeSincePosted;
  }

  get imagePath => _imagePath;
  get podcastName => _podcastName;
  get timeSincePosted => _timeSincePosted;
  get topic => _topic;
  get description => _description;
}