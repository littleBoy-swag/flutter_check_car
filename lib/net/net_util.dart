import 'dart:collection';
import 'dart:io';

import 'package:checkcar/common/constant.dart';
import 'package:checkcar/net/req_service.dart';
import 'package:dio/dio.dart';

class NetUtil {
  static NetUtil _instance;
  static ReqService _reqService;

  NetUtil() {
    var options = BaseOptions(
        connectTimeout: 15 * 1000, receiveTimeout: 10 * 1000, baseUrl: BASE_URL);
    Dio dio = Dio(options);
    _reqService = ReqService(dio);
  }

  static ReqService getInstance() {
    if (_instance == null) {
      _instance = NetUtil();
    }
    return _getReqService();
  }

  static ReqService _getReqService() {
    return _reqService;
  }
}

class HeadInterceptor extends Interceptor {
  @override
  Future onRequest(RequestOptions options) {
    var headers = HashMap<String, String>();
    headers["Charset"] = "UTF-8";
    headers["Connection"] = "keep-alive";
    headers["Accept"] = "*/*";
    headers["x-platform"] = Platform.isAndroid ? "android" : "ios";
    headers["Content-Type"] = "application/json";

    options.headers = headers;
    return super.onRequest(options);
  }
}
