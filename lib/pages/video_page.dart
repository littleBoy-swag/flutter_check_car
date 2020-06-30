import 'package:flutter/material.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        leading: InkWell(
          child: Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.of(context).maybePop();
          },
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "车源视频",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: Container(
        child: Center(
          child: Text("视频页"),
        ),
      ),
    );
  }
}
