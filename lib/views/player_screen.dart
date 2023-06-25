import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:velocity_x/velocity_x.dart';

class PlayerScreen extends StatefulWidget {
  final snap;
  const PlayerScreen({super.key, required this.snap});

  @override
  State<PlayerScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayerScreen> {
  late VideoPlayerController controller;
  ChewieController? chewieController;

  Future<void> loadVideoPlayer() async {
    controller = VideoPlayerController.network(
        "${widget.snap['video_link']}");

    await Future.wait([controller.initialize()]);

    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: false,
      looping: false,
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      loadVideoPlayer();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Video Player",
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4/3,
            child: Container(
              color: Colors.black,
              child: chewieController != null &&
                      chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(controller: chewieController!)
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircularProgressIndicator(),
                        12.heightBox,
                        const Text('Loading')
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
