import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:my_whatsapp/CustomUI/video_view.dart';
import 'package:my_whatsapp/Pages/camera_view.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

List<CameraDescription>? cameras;

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});
  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _cameraController;

  late Future<void> cameraValue;
  bool isRecording = false;
  String videoPath = '';

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_cameraController);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Positioned(
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.only(top: 5, bottom: 5),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          )),
                      GestureDetector(
                          onLongPress: () async {
                            final path = join(
                                (await getTemporaryDirectory()).path,
                                "${DateTime.now()}.mp4");
                            await _cameraController.startVideoRecording();
                            setState(() {
                              isRecording = true;
                              videoPath = path;
                            });
                          },
                          onLongPressUp: () async {
                            await _cameraController.stopVideoRecording();
                            setState(() {
                              isRecording = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) =>
                                        VideoView(path: videoPath)));
                          },
                          onTap: () {
                            if (!isRecording) takePicture(context);
                          },
                          child: isRecording
                              ? const Icon(
                                  Icons.radio_button_on,
                                  color: Colors.red,
                                  size: 80,
                                )
                              : const Icon(
                                  Icons.panorama_fish_eye,
                                  color: Colors.white,
                                  size: 70,
                                )),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flip_camera_ios,
                            color: Colors.white,
                            size: 28,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Hold for video, tap for photo',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePicture(BuildContext context) async {
    final path =
        join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile pictureFile = await _cameraController.takePicture();
    await pictureFile.saveTo(path);
    // ignore: use_build_context_synchronously
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (builder) => CameraView(
                  path: path,
                )));
  }
}
