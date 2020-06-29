import 'package:checkcar/common/common_color.dart';
import 'package:checkcar/common/common_style.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatefulWidget {

  CarItemWidget({Key key}) :super(key: key);

  @override
  _CarItemWidgetState createState() => _CarItemWidgetState();
}

class _CarItemWidgetState extends State<CarItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Text(
                          "2012款 一汽-大众CC 尊贵版",
                          style: titleStyle,
                        )),
                    Text(
                      "待审核",
                      style: TextStyle(fontSize: 14, color: Color(c_ff6600)),
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Text(
                  "提交发车时间：2020-06-16 18:53:32",
                  style: sub1TitleStyle,
                ),
                SizedBox(height: 10,),
                Text(
                  "AI审核结果：图片和品牌不对应，无法识别",
                  style: sub2TitleStyle,
                ),
              ],
            ),
          ),
        ),
      ),
      elevation: 4,
    );
  }
}
