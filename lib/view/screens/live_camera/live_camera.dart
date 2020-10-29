import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:security_camera_app/models/camera.dart';

class LiveCamera extends StatefulWidget {
  final CameraModel cameraModel;

  const LiveCamera({this.cameraModel});

  @override
  _LiveCameraState createState() => _LiveCameraState();
}

class _LiveCameraState extends State<LiveCamera> {
  VlcPlayerController controller;
  final FijkPlayer player = FijkPlayer();

  void initState() {
    controller = new VlcPlayerController(
      onInit: () {
        controller.play();
        player.setDataSource(
            'rtsp://freja.hiof.no:1935/rtplive/definst/hessdalen03.stream',
            autoPlay: true,
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Color(0xFF002c55),
        title: Text('Camera ${widget.cameraModel.name}'),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 5,
        ),
        children: [
          _buildText('HTTP'),
          Container(
            width: screenWidth,
            height: screenWidth * 9 / 16,
            child: VlcPlayer(
              aspectRatio: 16 / 9,
              url: 'http://213.226.254.135:91/mjpg/video.mjpg',
              controller: controller,
              placeholder: Center(child: CircularProgressIndicator()),
            ),
          ),
          _buildText('RTSP'),
          Container(
            width: screenWidth,
            height: screenWidth * 9 / 16,
            alignment: Alignment.center,
            child: FijkView(
              player: player,
            ),
          ),
        ],
      ),
    );
  }

  _buildText(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
