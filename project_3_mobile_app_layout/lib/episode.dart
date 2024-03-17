import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'DataSource.dart';

const double _headerHeight = 40;
const Color _bgColor = Color(0xfffdf9f6);
const Color _lineColor = Color(0xffe2dedb);

class Episode extends StatelessWidget {

  // TODO: чому це не працює тут, а в main.dart все окей?
  // final DataSource dataSource = DataSource();
  // Color bgColor = dataSource.bgColor;

  late final String _imagePath;
  late final String _podcastName;
  late final String _timeSincePosted;
  late final String _topic;
  late final String _description;

  static const String justPosted = "A few moments ago";

  Episode({super.key, required String imagePath, required String podcastName,
    required String topic, required String description,
    String timeSincePosted = justPosted}) {
    _imagePath = imagePath;
    _podcastName = podcastName;
    _topic = topic;
    _description = description;
    _timeSincePosted = timeSincePosted;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: _bgColor,
          border: Border(
            top: BorderSide(
              color: _lineColor,
            ),
          )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // PODCAST's NAME AND COVER
          SizedBox(
            height: _headerHeight,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    _imagePath,
                  ),
                ),

                const SizedBox(width: 10,),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_podcastName),
                    Text(_timeSincePosted, style: const TextStyle(
                      color: Colors.grey
                    ),)
                  ],
                )
              ],
            ),
          ),

          const SizedBox(height: 5,),

          // EPISODE's TOPIC
          Text(
            _topic,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)
          ),

          const SizedBox(height: 5,),

          // EPISODE's DESCRIPTION
          Text(
            _description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

}