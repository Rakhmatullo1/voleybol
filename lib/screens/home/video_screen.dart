import 'package:appnew/screens/home_screen.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideosScreenMore extends StatefulWidget {
  static String route = "/video-more";
  const VideosScreenMore({super.key});

  @override
  State<VideosScreenMore> createState() => _VideosScreenMoreState();
}

class _VideosScreenMoreState extends State<VideosScreenMore> {
  List<dynamic> videos = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    videos = ModalRoute.of(context)!.settings.arguments as List;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        title: text('Video Lavhalar', accentColor),
        backgroundColor: backGroungColor,
      ),
      body: Column(
        children: [
          Expanded(
            child: videos.isEmpty
                ? const Center(child: Text("No Images Selected"))
                : ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              VideoPlayerScreen.route,
                              arguments: "${videos[index]["videoLink"]}");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15)),
                          padding: const EdgeInsets.all(10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              
                                videos[index]["thumb"] == ""
                                    ? "https://gnfuncjcsczaqlftphym.supabase.co/storage/v1/object/public/volleyball//download.jpeg"
                                    : "${videos[index]["thumb"]}",
                                height: 150, loadingBuilder:
                                    (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                          
                              return Center(
                                child: CircularProgressIndicator(
                                  value:
                                      loadingProgress.expectedTotalBytes !=
                                              null
                                          ? loadingProgress
                                                  .cumulativeBytesLoaded /
                                              (loadingProgress
                                                      .expectedTotalBytes ??
                                                  1)
                                          : null,
                                ),
                              );
                            }, fit: BoxFit.cover),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}

Widget text(String s, Color accentColor) {
  return Text(
    s,
    style: TextStyle(color: accentColor),
  );
}

class VideoPlayerScreen extends StatefulWidget {
  static const String route = "/video-player";
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late final VideoPlayerController _videoController;
  ChewieController? _chewieController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final url = ModalRoute.of(context)!.settings.arguments as String;
    _initializePlayer(url);
  }

  Future<void> _initializePlayer(String url) async {
    _videoController = VideoPlayerController.network(url);
    await _videoController.initialize();
    _chewieController = ChewieController(
      videoPlayerController: _videoController,
      autoPlay: true,
      looping: false,
      allowFullScreen: true,
      allowMuting: true,
    );
    setState(() {});
  }

  @override
  void dispose() {
    _videoController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backGroungColor,
      appBar: AppBar(
        title: text("Video lavhalar", accentColor),
        backgroundColor: backGroungColor,
      ),
      body: Center(
        child:
            _chewieController?.videoPlayerController.value.isInitialized == true
                ? AspectRatio(
                    aspectRatio: _videoController.value.aspectRatio,
                    child: Chewie(controller: _chewieController!),
                  )
                : const CircularProgressIndicator(),
      ),
    );
  }
}
