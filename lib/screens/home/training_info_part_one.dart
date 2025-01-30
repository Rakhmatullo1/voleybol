import 'package:appnew/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class TrainingInfoPartOneScreen extends StatefulWidget {
  static String route = "/training-info-part-one";

  const TrainingInfoPartOneScreen({super.key});
  @override
  State<TrainingInfoPartOneScreen> createState() =>
      _TrainingInfoPartOneScreenState();
}

class _TrainingInfoPartOneScreenState extends State<TrainingInfoPartOneScreen> {
  late YoutubePlayerController _controller;
  late YoutubePlayerController _controllerOne;
  String name = "";
  Map data = {};
  bool isOnePlayed = false;
  bool isGameNull = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    data = ModalRoute.of(context)!.settings.arguments as Map;
    name = data["name"];
    String videoUrl = data["value"]["video"]["url"] as String;
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
    if (data["value"]["oyin"]["url"] != null) {
      isGameNull = false;
      String videouUrlOne = data["value"]["oyin"]["url"];
      String? videoIdone = YoutubePlayer.convertUrlToId(videouUrlOne);
      _controllerOne = YoutubePlayerController(
          initialVideoId: videoIdone!,
          flags: const YoutubePlayerFlags(autoPlay: true));
    }
    _controller = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: const YoutubePlayerFlags(autoPlay: true));
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _controllerOne.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        backgroundColor: backGroungColor,
        iconTheme: const IconThemeData(color: accentColor),
        title: Text(
          data["name"],
          style: const TextStyle(
              color: accentColor, fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Video: ",
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: accentColor,
                  progressColors: const ProgressBarColors(
                    playedColor: Color.fromARGB(150, 255, 127, 80),
                    handleColor: accentColor,
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(height: 0),
                const SizedBox(height: 30),
                const Text(
                  "Dars: ",
                  style: TextStyle(
                    color: accentColor,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    data["value"]["dars"],
                    style: TextStyle(color: Colors.grey.shade500),
                    textAlign: TextAlign.justify,
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(height: 0),
                const SizedBox(height: 30),
                if (!isGameNull) ...{
                  const Text(
                    "O'yin: ",
                    style: TextStyle(
                      color: accentColor,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 20),
                  YoutubePlayer(
                    controller: _controllerOne,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: accentColor,
                    progressColors: const ProgressBarColors(
                      playedColor: Color.fromARGB(150, 255, 127, 80),
                      handleColor: accentColor,
                    ),
                  ),
                }
              ],
            ),
          ),
        ),
      ),
    );
  }
}
