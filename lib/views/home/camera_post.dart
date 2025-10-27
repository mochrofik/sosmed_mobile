import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yure_connect_apps/provider/post_provider.dart';
import 'package:yure_connect_apps/utils/app_key.dart';

class CameraPost extends StatefulWidget {
  const CameraPost({super.key});

  @override
  State<CameraPost> createState() => _CameraPostState();
}

class _CameraPostState extends State<CameraPost>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  CameraController? controller;
  XFile? imageFile;
  XFile? videoFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Camera example')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color:
                      controller != null && controller!.value.isRecordingVideo
                          ? Colors.redAccent
                          : Colors.grey,
                  width: 3.0,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(child: _cameraPreviewWidget()),
              ),
            ),
          ),
          _captureControlRowWidget(context),
          // _modeControlRowWidget(),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
                // children: <Widget>[_cameraTogglesRowWidget(), _thumbnailWidget()],
                ),
          ),
        ],
      ),
    );
  }

  Widget _cameraPreviewWidget() {
    final CameraController? cameraController = controller;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return Listener(
        // onPointerDown: (_) => _pointers++,
        // onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return GestureDetector(
                  //   behavior: HitTestBehavior.opaque,
                  //   onScaleStart: _handleScaleStart,
                  //   onScaleUpdate: _handleScaleUpdate,
                  //   onTapDown: (TapDownDetails details) =>
                  //       onViewFinderTap(details, constraints),
                  );
            },
          ),
        ),
      );
    }
  }

  Widget _captureControlRowWidget(context) {
    final CameraController? cameraController = controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          onPressed: () {
            Provider.of<PostProvider>(context, listen: false)
                .pickImage(ImageSource.gallery);
          },
          icon: Icon(FontAwesomeIcons.image),
        ),
        IconButton(
          icon: const Icon(Icons.camera_alt),
          color: Colors.blue,
          onPressed: cameraController != null &&
                  cameraController.value.isInitialized &&
                  !cameraController.value.isRecordingVideo
              ? onTakePictureButtonPressed
              : null,
        ),
        // IconButton(
        //   icon: const Icon(Icons.videocam),
        //   color: Colors.blue,
        //   onPressed: cameraController != null &&
        //           cameraController.value.isInitialized &&
        //           !cameraController.value.isRecordingVideo
        //       ? onVideoRecordButtonPressed
        //       : null,
        // ),
        // IconButton(
        //   icon: cameraController != null &&
        //           cameraController.value.isRecordingPaused
        //       ? const Icon(Icons.play_arrow)
        //       : const Icon(Icons.pause),
        //   color: Colors.blue,
        //   onPressed: cameraController != null &&
        //           cameraController.value.isInitialized &&
        //           cameraController.value.isRecordingVideo
        //       ? cameraController.value.isRecordingPaused
        //           ? onResumeButtonPressed
        //           : onPauseButtonPressed
        //       : null,
        // ),
        // IconButton(
        //   icon: const Icon(Icons.stop),
        //   color: Colors.red,
        //   onPressed: cameraController != null &&
        //           cameraController.value.isInitialized &&
        //           cameraController.value.isRecordingVideo
        //       ? null
        //       //  onStopButtonPressed
        //       : null,
        // ),
        // IconButton(
        //   icon: const Icon(Icons.pause_presentation),
        //   color:
        //       cameraController != null && cameraController.value.isPreviewPaused
        //           ? Colors.red
        //           : Colors.blue,
        //   onPressed: null,
        //   // cameraController == null ? null : onPausePreviewButtonPressed,
        // ),
      ],
    );
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          // videoController?.dispose();
          // videoController = null;
        });
        if (file != null) {
          showSnackbar('Picture saved to ${file.path}');
        }
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showSnackbar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      // _showCameraException(e);
      return null;
    }
  }
}
