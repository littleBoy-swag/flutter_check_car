import 'dart:async';

import 'package:checkcar/common/common_color.dart';
import 'package:checkcar/common/common_style.dart';
import 'package:checkcar/pages/big_image_page.dart';
import 'package:checkcar/pages/video_page.dart';
import 'package:checkcar/route/bundle.dart';
import 'package:checkcar/route/page_routes.dart';
import 'package:checkcar/utils/dialog_util.dart';
import 'package:checkcar/utils/forbidshot_util.dart';
import 'package:checkcar/widgets/custom_radio.dart';
import 'package:checkcar/widgets/item_widget.dart';
import 'package:checkcar/widgets/player/tencent_player_bottom_widget.dart';
import 'package:checkcar/widgets/player/tencent_player_gesture_cover.dart';
import 'package:checkcar/widgets/player/tencent_player_loading.dart';
import 'package:checkcar/widgets/pop_widget.dart';
import 'package:checkcar/widgets/v_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_tencentplayer/controller/tencent_player_controller.dart';
import 'package:flutter_tencentplayer/view/tencent_player.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:screen/screen.dart';
import 'package:video_player/video_player.dart';

class CarDetailPage extends StatefulWidget {
  final Bundle bundle;

  CarDetailPage({this.bundle});

  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  TextEditingController _reasonController;

//  VideoPlayerController _videoPlayerController;
  TencentPlayerController _playerController;

  final data = [
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538350&di=3c7841b4f38254f65f18aaa78b91ac0f&imgtype=0&src=http%3A%2F%2Fimg3.imgtn.bdimg.com%2Fit%2Fu%3D333824343%2C3867419450%26fm%3D214%26gp%3D0.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538069&di=7c3b91fb45d593e0f23df3622ba67fa1&imgtype=0&src=http%3A%2F%2Fcar0.autoimg.cn%2Fupload%2Fspec%2F13452%2Fu_20120723095341589264.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497556626&di=7896521541f4842cce64dcd8cb64bbfe&imgtype=0&src=http%3A%2F%2Fimg0.imgtn.bdimg.com%2Fit%2Fu%3D2611392705%2C2273559848%26fm%3D214%26gp%3D0.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538067&di=69cfc6ab1bd390d2046a84c4bbea8946&imgtype=0&src=http%3A%2F%2Fimg.ewebweb.com%2Fuploads%2F20190623%2F21%2F1561296099-qWuzENTlxe.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593497538067&di=00bbb1fd142cd158b15f1617bafa529a&imgtype=0&src=http%3A%2F%2Fpic29.nipic.com%2F20130522%2F12421584_133951593000_2.jpg",
    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1593506225788&di=8913b4d47f4e3f6878e644927cea2adb&imgtype=0&src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fitem%2F201412%2F27%2F20141227150432_FeS8P.jpeg"
  ];

  String _indexStr = "";
  int _index = 0;
  String groupId = "";
  String videoShowId = "1";
  bool showCover = false;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _reasonController = TextEditingController();
//    _videoPlayerController = VideoPlayerController.network("http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4")
//      ..initialize().then((value) {
//        setState(() {});
//      });
    _playerController = TencentPlayerController.network(
        "http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4")
      ..initialize().then((value) {
        setState(() {});
      });
    _playerController.addListener(() {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    setState(() {
      _indexStr = "1/" + data.length.toString();
    });
    hideCover();
    ForbidShotUtil.initForbid(context);
    Screen.keepOn(true);
  }

  @override
  void dispose() {
    _reasonController?.dispose();
    _reasonController = null;
    _playerController?.dispose();
    _playerController = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(c_f2f7fa),
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
          widget.bundle.getString("title") ?? "",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          reverse: false,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: <Widget>[
              _buildPicInfo(),
              VWidget(height: 10),
              _buildVideoInfo(),
              VWidget(height: 10),
              _buildCarInfo(),
              VWidget(height: 10),
              _buildAIResult(),
              VWidget(height: 10),
              _buildManualReason(),
            ],
          ),
        ),
      ),
    );
  }

  /// 车辆信息
  Widget _buildCarInfo() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "车辆信息",
              style: infoTitleStyle,
            ),
            VWidget(
              height: 15,
            ),
            ItemWidget(
              label: "发车人手机号码",
              content: "180****5656",
              contentColor: Color(c_2a8cff),
            ),
            VWidget(
              height: 20,
            ),
            ItemWidget(
              label: "车身颜色",
              content: "白色",
            ),
            VWidget(
              height: 20,
            ),
            ItemWidget(
              label: "车架号",
              content: "LSGJS52U16H092004",
            ),
            VWidget(
              height: 20,
            ),
            ItemWidget(
              label: "上牌日期",
              content: "2020-01-01",
            ),
            VWidget(
              height: 20,
            ),
            ItemWidget(
              label: "行驶里程",
              content: "2.00",
            ),
            VWidget(
              height: 20,
            ),
            ItemWidget(
              label: "排放标准",
              content: "1.3",
            ),
          ],
        ),
      ),
    );
  }

  /// AI审核结果
  Widget _buildAIResult() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "AI审核",
              style: infoTitleStyle,
            ),
            VWidget(height: 15),
            Text(
              "AI审核结果：图片和品牌不对应，无法识别",
              style: TextStyle(fontSize: 16, color: Color(c_333333)),
            ),
            VWidget(height: 10),
            Text(
              "AI审核结果可能与实际存在偏差，可用作参考，但不作为审核不通过的必备原因",
              style: sub2TitleStyle,
            ),
          ],
        ),
      ),
    );
  }

  /// 视频信息
  Widget _buildVideoInfo() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "视频信息",
              style: infoTitleStyle,
            ),
            VWidget(
              height: 10,
            ),
            Text(
              "查看视频内容与本车型及其图片是否匹配一致，视频声音是否正常",
              style: TextStyle(fontSize: 14, color: Color(c_999999)),
            ),
            VWidget(height: 15),
            GestureDetector(
              child: Container(
                width: double.infinity,
                child: AspectRatio(
                  aspectRatio: 4 / 3,
                  child: Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        child: _playerController.value.initialized
                            ? TencentPlayer(_playerController)
                            : Center(
                                child: CircularProgressIndicator(),
                              ),
                      ),

                      ///支撑全屏
                      Container(),

                      ///半透明浮层
                      showCover
                          ? Container(
                              color: Color(0x7F000000),
                            )
                          : SizedBox(),

                      ///处理滑动手势
                      TencentPlayerGestureCover(
                        controller: _playerController,
                        behavingCallBack: delayHideCover,
                      ),

                      ///加载loading
                      TencentPlayerLoading(
                        controller: _playerController,
                        iconW: 53,
                      ),
                      showCover
                          ? Positioned(
                              child: TencentPlayerBottomWidget(
                                isShow: showCover,
                                controller: _playerController,
                                showClearBtn: false,
                                showRateBtn: false,
                                changeClear: (index){},
                                behavingCallBack: (){
                                  delayHideCover();
                                },
                              ),
                        left: 0,
                        bottom: 0,
                        right: 40,
                            )
                          : SizedBox(),
                      showCover
                          ? Positioned(
                              child: GestureDetector(
                                child: Image.asset(
                                  "images/ic_enlarge.png",
                                  width: 20,
                                  height: 20,
                                ),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => VideoPage(),
                                  ));
                                },
                              ),
                              right: 15,
                              bottom: 15,
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ),
              behavior: HitTestBehavior.opaque,
              onTap: () {
                hideCover();
              },
              onDoubleTap: () {
                if (_playerController.value.isPlaying) {
                  _playerController.pause();
                } else {
                  _playerController.play();
                }
              },
            ),
            VWidget(height: 15),
            Row(
              children: <Widget>[
                CustomRadio(
                    content: "客户端展示",
                    groupId: videoShowId,
                    id: "1",
                    callback: () {
                      setState(() {
                        videoShowId = "1";
                      });
                    }),
                SizedBox(
                  width: 20,
                ),
                CustomRadio(
                    content: "客户端不展示",
                    groupId: videoShowId,
                    id: "2",
                    callback: () {
                      setState(() {
                        videoShowId = "2";
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 人工审核驳回原因
  Widget _buildManualReason() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "人工审核驳回原因",
              style: infoTitleStyle,
            ),
            VWidget(
              height: 15,
            ),
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: CustomRadio(
                          content: "照片与车型不符",
                          groupId: groupId,
                          id: "1",
                          callback: () {
                            setState(() {
                              groupId = "1";
                            });
                          }),
                    )),
                    Expanded(
                        child: Container(
                      child: CustomRadio(
                          content: "缺少车辆外观图片",
                          groupId: groupId,
                          id: "2",
                          callback: () {
                            setState(() {
                              groupId = "2";
                            });
                          }),
                    ))
                  ],
                ),
                VWidget(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      child: CustomRadio(
                          content: "外观图片拍摄不完整",
                          groupId: groupId,
                          id: "3",
                          callback: () {
                            setState(() {
                              groupId = "3";
                            });
                          }),
                    )),
                    Expanded(
                        child: Container(
                      child: CustomRadio(
                          content: "图片不是实拍图",
                          groupId: groupId,
                          id: "4",
                          callback: () {
                            setState(() {
                              groupId = "4";
                            });
                          }),
                    ))
                  ],
                ),
                VWidget(height: 10),
                CustomRadio(
                    content: "新车板块不可发布二手车",
                    groupId: groupId,
                    id: "5",
                    callback: () {
                      setState(() {
                        groupId = "5";
                      });
                    }),
                VWidget(height: 10),
                CustomRadio(
                    content: "其他原因",
                    groupId: groupId,
                    id: "6",
                    callback: () {
                      setState(() {
                        groupId = "6";
                      });
                    })
              ],
            ),
            VWidget(height: 10),
            TextField(
              maxLines: 2,
              style: TextStyle(fontSize: 14, color: Color(c_333333)),
              decoration: InputDecoration(
                hintText: "请填写其他原因",
                hintStyle: TextStyle(fontSize: 14, color: Color(c_cccccc)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Color(c_e5e5e5),
                      width: 1,
                    )),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Color(c_e5e5e5),
                      width: 1,
                    )),
              ),
            ),
            VWidget(height: 15),
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                    child: InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    height: 48,
                    child: Text(
                      "驳回",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    color: Color(c_ff6600),
                  ),
                  onTap: () {
                    DialogUtil.showRelatedCarDialog(context, "2", () {
                      Fluttertoast.showToast(msg: "取消");
                    }, () {
                      Fluttertoast.showToast(msg: "确定驳回");
                    });
                  },
                )),
                Expanded(
                  child: InkWell(
                    child: Container(
                      alignment: Alignment.center,
                      height: 48,
                      child: Text(
                        "审核通过",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      color: Color(c_2a8cff),
                    ),
                    onTap: () {
                      print("审核通过");
                    },
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 车辆标题和图片
  Widget _buildPicInfo() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "2018款 凯越 15N 手动精英型",
              style: infoTitleStyle,
            ),
            VWidget(height: 10),
            Text(
              "外观颜色：白色",
              style: TextStyle(fontSize: 14, color: Color(c_333333)),
            ),
            VWidget(height: 15),
            Container(
              width: MediaQuery.of(context).size.width,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Stack(
                  children: <Widget>[
                    ExtendedImageGesturePageView(
                      onPageChanged: (p) {
                        _index = p;
                        setState(() {
                          _indexStr =
                              (p + 1).toString() + "/" + data.length.toString();
                        });
                      },
                      children: data
                          .map((e) => Container(
                                child: ExtendedImage.network(e,
                                    cache: true,
                                    mode: ExtendedImageMode.gesture,
                                    fit: BoxFit.cover,
                                    borderRadius: BorderRadius.circular(12),
                                    shape: BoxShape.rectangle,
                                    initGestureConfigHandler: (state) {
                                  return GestureConfig(inPageView: true);
                                }),
                              ))
                          .toList(),
                    ),
                    Positioned(
                      child: GestureDetector(
                        child: Image.asset(
                          "images/ic_enlarge.png",
                          width: 20,
                          height: 20,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                              context, RouteConstant.BIG_IMAGE_PAGE,
                              arguments: new Bundle()
                                ..putList("img_list", data)
                                ..putInt("index", _index));
                        },
                      ),
                      right: 15,
                      bottom: 15,
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
                      bottom: 15,
                      right: 55,
                    ),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Color(c_66000000),
                            borderRadius: BorderRadius.circular(11)),
                        height: 22,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          _indexStr,
                          style: TextStyle(fontSize: 11, color: Colors.white),
                        ),
                      ),
                      top: 20,
                      right: 20,
                    ), //
                    Positioned(
                      child: GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "images/ic_pic_show_on_mobile_normal.png",
                              width: 15,
                              height: 15,
                            ),
                            SizedBox(width: 6),
                            Image.asset(
                              "images/ic_text_show_on_mobile.png",
                              width: 60,
                              height: 14,
                            )
                          ],
                        ),
                        onTap: () {
                          print("客户端展示");
                        },
                      ),
                      left: 15,
                      bottom: 15,
                    ),
                    Positioned(
                      child: GestureDetector(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              "images/ic_circle_normal.png",
                              width: 15,
                              height: 15,
                            ),
                            SizedBox(width: 6),
                            Image.asset(
                              "images/ic_text_main_pic.png",
                              width: 27,
                              height: 14,
                            ),
                          ],
                        ),
                        onTap: () {
                          print("主图");
                        },
                      ),
                      top: 15,
                      left: 15,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  hideCover() {
    if (!mounted) return;
    setState(() {
      showCover = !showCover;
    });
    delayHideCover();
  }

  delayHideCover() {
    if (timer != null) {
      timer.cancel();
      timer = null;
    }
    if (showCover) {
      timer = new Timer(Duration(seconds: 3), () {
        if (!mounted) return;
        setState(() {
          showCover = false;
        });
      });
    }
  }
}
