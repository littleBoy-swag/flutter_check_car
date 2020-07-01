
import 'package:flutter_easyrefresh/easy_refresh.dart';

var commonHeader = ClassicalHeader(
  refreshedText: "刷新结束",
  refreshText: "下拉刷新",
  refreshReadyText: "松开刷新",
  refreshingText: "正在刷新",
  refreshFailedText: "刷新失败",
  enableHapticFeedback: false
);

var commonFooter = ClassicalFooter(
  loadText: "正在加载",
  loadingText: "正在加载",
  loadFailedText: "加载失败",
  loadedText: "加载完成",
  noMoreText: "没有更多数据了",
  enableHapticFeedback: false
);