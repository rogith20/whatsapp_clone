import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key, this.path = ''});

  final String path;

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late VideoPlayerController _controller;
  bool show = false;
  FocusNode focusNode = FocusNode();
  final TextEditingController _tcontroller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.crop_rotate_sharp,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions_outlined,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.title,
              size: 27,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mode_edit_outlined,
              size: 27,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: WillPopScope(
          child: Stack(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                width: MediaQuery.of(context).size.width,
                child: _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 60,
                          child: Card(
                            color: const Color(0xFF1F2C34),
                            margin: const EdgeInsets.only(
                                left: 2, right: 2, bottom: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: TextFormField(
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                              ),
                              controller: _tcontroller,
                              focusNode: focusNode,
                              textAlignVertical: TextAlignVertical.center,
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              minLines: 1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      focusNode.unfocus();
                                      focusNode.canRequestFocus = false;
                                      show = !show;
                                    });
                                  },
                                  icon: Icon(
                                    show
                                        ? Icons.add_photo_alternate
                                        : Icons.emoji_emotions_outlined,
                                    color: const Color(0xFF8596a0),
                                  ),
                                ),
                                hintText: 'Add a caption...',
                                hintStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                                contentPadding: const EdgeInsets.all(5),
                                suffixIcon: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      onPressed: null,
                                      icon: Icon(
                                        Icons.looks_one,
                                        size: 25,
                                        color: Color(0xFF8596a0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 2, right: 5, bottom: 8),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xFF075E54),
                            radius: 26,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    show ? emojiSelect() : Container(),
                  ],
                ),
              ),
            ],
          ),
          onWillPop: () {
            if (show) {
              setState(() {
                show = false;
              });
            } else {
              Navigator.pop(context);
            }
            return Future.value(false);
          },
        ),
      ),
    );
  }

  Widget emojiSelect() {
    return SizedBox(
      height: 320,
      child: EmojiPicker(
        config: const Config(
            // columns: 7,
            ),
        onEmojiSelected: (category, emoji) {
          setState(() {
            _tcontroller.text = _tcontroller.text + emoji.emoji;
          });
        },
      ),
    );
  }
}
