import 'package:checkcar/common/common_color.dart';
import 'package:checkcar/common/common_style.dart';
import 'package:checkcar/widgets/item_widget.dart';
import 'package:checkcar/widgets/v_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class CarDetailPage extends StatefulWidget {
  @override
  _CarDetailPageState createState() => _CarDetailPageState();
}

class _CarDetailPageState extends State<CarDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(c_f2f7fa),
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "待审核车源",
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
            Container(
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12)),
                ),
              ),
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
                    print("驳回");
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
              width: double.infinity,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Swiper(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      child: Image.network(
                        "http://via.placeholder.com/288x188",
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12)),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
