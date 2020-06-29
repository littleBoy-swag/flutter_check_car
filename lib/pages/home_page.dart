import 'package:checkcar/pages/car_detail_page.dart';
import 'package:checkcar/widgets/car_item_widget.dart';
import 'package:checkcar/widgets/common_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final data = [
    Colors.green[50],
    Colors.green[100],
    Colors.green[200],
  ];

  EasyRefreshController _controller;
  int _count = 20;

  @override
  void initState() {
    _controller = EasyRefreshController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "专业版发车审核管理",
          style: TextStyle(color: Colors.black, fontSize: 17),
        ),
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/ic_filter.png',
                width: 16,
                height: 16,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => CarDetailPage(),
                ));
              }),
        ],
      ),
      body: Container(
        child: PageView(
          onPageChanged: (p) {
            print(p);
          },
          children: data.map((e) => _buildPage()).toList(),
        ),
      ),
    );
  }

  Widget _buildPage() {
    return EasyRefresh.custom(
      controller: _controller,
      enableControlFinishRefresh: false,
      enableControlFinishLoad: true,
      header: commonHeader,
      footer: commonFooter,
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print("refresh");
          setState(() {
            _count = 20;
            _controller.resetRefreshState();
          });
        });
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {
          print("loadMore");
          setState(() {
            _count += 10;
          });
          _controller.finishLoad(noMore: _count > 50);
        });
      },
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            return CarItemWidget(
              key: GlobalKey(),
            );
          }, childCount: _count),
        ),
      ],
    );
  }
}
