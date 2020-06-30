import 'package:checkcar/common/common_color.dart';
import 'package:checkcar/widgets/v_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class BigImagePage extends StatefulWidget {
  @override
  _BigImagePageState createState() => _BigImagePageState();
}

class _BigImagePageState extends State<BigImagePage> {
  final data = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538350&di=3c7841b4f38254f65f18aaa78b91ac0f&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D333824343%2C3867419450%26fm%3D214%26gp%3D0.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538069&di=7c3b91fb45d593e0f23df3622ba67fa1&imgtype=0&src=http%3A%2F%2Fcar0.autoimg.cn%2Fupload%2Fspec%2F13452%2Fu_20120723095341589264.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497556626&di=7896521541f4842cce64dcd8cb64bbfe&imgtype=0&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2611392705%2C2273559848%26fm%3D214%26gp%3D0.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538067&di=69cfc6ab1bd390d2046a84c4bbea8946&imgtype=0&src=http%3A%2F%2Fimg.ewebweb.com%2Fuploads%2F20190623%2F21%2F1561296099-qWuzENTlxe.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538067&di=00bbb1fd142cd158b15f1617bafa529a&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130522%2F12421584_133951593000_2.jpg"
  ];

  PageController _pageController;
  String indexStr = "";

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    indexStr = "1/" + data.length.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
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
                    mode: ExtendedImageMode.gesture,
                    initGestureConfigHandler: (state){
                      return GestureConfig(
                        inPageView: true
                      );
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
