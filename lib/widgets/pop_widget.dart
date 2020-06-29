import 'package:checkcar/widgets/line.dart';
import 'package:checkcar/widgets/pop_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../common/common_color.dart';
import '../common/common_style.dart';

class PopWidget extends StatefulWidget {
  @override
  _PopWidgetState createState() => _PopWidgetState();
}

class _PopWidgetState extends State<PopWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            height: 48,
            width: double.infinity,
            child: Row(
              children: <Widget>[
                Text(
                  "手机号码",
                  style: TextStyle(fontSize: 16, color: Color(c_333333)),
                ),
                Expanded(child: TextField()),
              ],
            ),
          ), // 手机号码
          Line(),
          PopItemWidget(
            prefix: "请选择状态",
            suffix: "全部",
            iconPath: 'images/ic_down_arrow.png',
            callback: () {
              Fluttertoast.showToast(msg: "请选择状态");
            },
          ),
          PopItemWidget(
            prefix: "视频状态",
            suffix: "全部",
            iconPath: 'images/ic_down_arrow.png',
            callback: () {
              Fluttertoast.showToast(msg: "视频状态");
            },
          ),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              "时间筛选",
              style: dialogTextStyle,
            ),
          ),
          PopItemWidget(
            prefix: "开始时间",
            suffix: "请选择开始时间",
            iconPath: 'images/ic_time.png',
            callback: () {
              Fluttertoast.showToast(msg: "请选择开始时间");
            },
          ),
          PopItemWidget(
            prefix: "结束时间",
            suffix: "请选择结束时间",
            iconPath: 'images/ic_time.png',
            callback: () {
              Fluttertoast.showToast(msg: "请选择结束时间");
            },
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 44,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Color(c_2a8cff)),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            "重置",
                            style: TextStyle(fontSize: 16, color: Color(c_2a8cff)),
                          ),
                        ),
                        onTap: (){
                          Fluttertoast.showToast(msg: "重置");
                        },
                      )),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          height: 44,
                          decoration: BoxDecoration(
                            color: Color(c_2a8cff),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            "搜索",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                        onTap: (){
                          Fluttertoast.showToast(msg: "搜索");
                        },
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
