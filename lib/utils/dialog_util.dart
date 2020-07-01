import 'package:checkcar/common/common_color.dart';
import 'package:checkcar/common/common_style.dart';
import 'package:checkcar/widgets/custom_radio.dart';
import 'package:checkcar/widgets/v_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DialogUtil {
  /// 展示关联车源dialog
  static void showRelatedCarDialog(
      BuildContext context, String groupId, Function cancel, Function confirm) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, state) {
              return CupertinoAlertDialog(
                title: Text(
                  "关联车源及处理",
                  style: TextStyle(
                      fontSize: 17,
                      color: Color(c_333333),
                      fontWeight: FontWeight.bold),
                ),
                content: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      VWidget(height: 20),
                      Text(
                        "关联车源",
                        style: offSaleStyle,
                      ),
                      VWidget(height: 10),
                      Text(
                        "2017款 福睿斯 1.5L自动舒适型",
                        style: itemStyle,
                      ),
                      VWidget(height: 20),
                      Text(
                        "关联车源处理",
                        style: offSaleStyle,
                      ),
                      VWidget(height: 10),
                      Row(
                        children: <Widget>[
                          CustomRadio(
                              content: "下架关联车",
                              groupId: groupId,
                              id: "1",
                              callback: () {
                                state(() {
                                  groupId = "1";
                                });
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          CustomRadio(
                              content: "不下架",
                              groupId: groupId,
                              id: "2",
                              callback: () {
                                state(() {
                                  groupId = "2";
                                });
                              })
                        ],
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      cancel();
                      Navigator.of(context).pop();
                    },
                    child: new Text(
                      "取消",
                      style: TextStyle(
                          color: Color(c_666666),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      confirm();
                      Navigator.of(context).pop();
                    },
                    child: new Text(
                      "确定驳回",
                      style: TextStyle(
                          color: Color(c_ff6600),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              );
            },
          );
        });
  }

  /// 底部弹框
  static void showActionSheetDialog(BuildContext context) {
    showModalBottomSheet(context: context, builder: (context){
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(title: Text("全部"),),
          ListTile(title: Text("待审核"),),
          ListTile(title: Text("已下架"),),
          ListTile(title: Text("已上架"),),
        ],
      );
    });
  }

  /// 日期选择
  static void showDatePicker(BuildContext context) {
    DatePicker.showDatePicker(context, showTitleActions: true,
        minTime: DateTime(2018, 5, 3),
        maxTime: DateTime(2020, 7, 1),
        onChanged: (date) {},
        onConfirm: (date) {},
        currentTime: DateTime.now(),
        locale: LocaleType.zh);
  }

}
