import 'dart:ui';

import 'package:checkcar/common/common_style.dart';
import 'package:checkcar/pages/big_image_page.dart';
import 'package:checkcar/pages/car_detail_page.dart';
import 'package:checkcar/route/bundle.dart';
import 'package:checkcar/route/page_routes.dart';
import 'package:checkcar/widgets/car_item_widget.dart';
import 'package:checkcar/widgets/common_widget.dart';
import 'package:checkcar/widgets/pop/pop_route.dart';
import 'package:checkcar/widgets/pop/pop_up_window.dart';
import 'package:checkcar/widgets/pop_widget.dart';
import 'package:checkcar/widgets/v_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_screenutil/screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  TabController _tabController;
  EasyRefreshController _controller;
  int _count = 0;
  int _curIndex = 0;

  @override
  void initState() {
    _controller = EasyRefreshController();
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
    _tabController.addListener(() {
      if(_tabController.index == _tabController.animation.value) {
        setState(() {
          _curIndex = _tabController.index;
          _controller.callRefresh();
        });
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.callRefresh();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
    _tabController = null;
    _controller?.dispose();
    _controller = null;
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
                Navigator.of(context).push(PopRoute(
                  child: PopUpWindow(
                    left: 0,
                    top: 56 + MediaQueryData
                        .fromWindow(window)
                        .padding
                        .top, // appbar高度+状态栏高度
                    child: PopWidget(),
                    onClick: () {
                      print("pop");
                      Navigator.of(context).pop();
                    },
                  ),
                ));
              }),
        ],
        bottom: TabBar(
          tabs: [
            Tab(
              child: Text("平台车源(499)",
                  style: (_curIndex == 0) ? tabSelectedStyle : tabStyle),
            ),
            Tab(
              child: Text("同行批发(999)",style: (_curIndex == 1) ? tabSelectedStyle : tabStyle),
            ),
            Tab(
              child: Text("新车批售(999)",style: (_curIndex == 2) ? tabSelectedStyle : tabStyle),
            ),
          ],
          isScrollable: true,
          controller: _tabController,
        ),
      ),
      body: Container(
        child: _buildPage(),
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
              status: index % 3,
              callback: () {
                Navigator.pushNamed(
                    context, RouteConstant.CAR_DETAIL_PAGE,
                    arguments: Bundle()
                      ..putString("title", "待审核车源"));
              },
            );
          }, childCount: _count),
        ),
      ],
      emptyWidget: _count == 0 ? Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Image.asset('images/ic_empty.png', width: 125, height: 164,),
              VWidget(height: 20,),
              Text("暂无数据")
            ],
          ),
        ),
      ) : null,
    );
  }
}
