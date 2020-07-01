import 'package:checkcar/common/common_color.dart';
import 'package:checkcar/route/bundle.dart';
import 'package:checkcar/widgets/v_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BigImagePage extends StatefulWidget {

  final Bundle bundle;
  BigImagePage({this.bundle});

  @override
  _BigImagePageState createState() => _BigImagePageState();
}

class _BigImagePageState extends State<BigImagePage> {
  var data = [];
  var _index = 0;

  PageController _pageController;
  String indexStr = "";
  final GlobalKey<ExtendedImageEditorState> editorKey =
      GlobalKey<ExtendedImageEditorState>();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    data = widget.bundle.getList("img_list");
    _index = widget.bundle.getInt("index");
    indexStr = "1/" + data.length.toString();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pageController.jumpToPage(_index);
    });
  }

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
          "车源图片",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "2018款 凯越 15N 手动精英型",
                      style: TextStyle(
                          fontSize: 17,
                          color: Color(c_333333),
                          fontWeight: FontWeight.bold),
                    ),
                    VWidget(height: 10),
                    Text(
                      "外观颜色：白色",
                      style: TextStyle(fontSize: 14, color: Color(c_333333)),
                    )
                  ],
                ),
              ),
            ),
            _buildLoopImages()
          ],
        ),
      ),
    );
  }

  /// 下边轮播
  Widget _buildLoopImages() {
    return Expanded(
        child: Stack(
      children: <Widget>[
        ExtendedImageGesturePageView(
          controller: _pageController,
          onPageChanged: (p) {
            print(p);
            setState(() {
              indexStr = (p + 1).toString() + "/" + data.length.toString();
            });
          },
          children: data
              .map(
                (url) => Container(
                  color: Colors.black,
                  child: ExtendedImage.network(
                    url,
                    cache: true,
                    fit: BoxFit.contain,
                    mode: ExtendedImageMode.gesture,
                    extendedImageEditorKey: editorKey,
                    initGestureConfigHandler: (state) {
                      return GestureConfig(inPageView: true);
                    },
                  ),
                ),
              )
              .toList(),
        ),
        Positioned(
          child: Text(
            "主图",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          left: 10,
          top: 10,
        ),
        Positioned(
          child: GestureDetector(
            child: Image.asset(
              "images/ic_rotate.png",
              width: 20,
              height: 20,
            ),
            onTap: () {
              print("旋转");
            },
          ),
          bottom: 20,
          right: 20,
        ), //旋转
        Positioned(
          child: Container(
            decoration: BoxDecoration(
                color: Color(c_66000000),
                borderRadius: BorderRadius.circular(11)),
            height: 22,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              indexStr,
              style: TextStyle(fontSize: 11, color: Colors.white),
            ),
          ),
          top: 20,
          right: 20,
        ), //index
      ],
    ));
  }
}
