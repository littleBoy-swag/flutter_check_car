import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';

typedef Success = void Function(String json);
typedef Error = void Function(int code, String msg);

///
/// 初步封装网络请求，后期可能做调整
///
class ReqService {
  ReqService(this.dio);

  Dio dio;

  void get(String url,
      {Map<String, dynamic> params, Success success, Error error}) {
    dio.get(url, queryParameters: params).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          success(response.data);
        }
      } else {
        int code = response.statusCode;
        String msg = response.statusMessage;
        if (error != null) {
          error(code, msg);
        }
      }
    });
  }

  void post(String url,
      {Map<String, dynamic> params, Success success, Error error}) {
    dio.post(url, queryParameters: params).then((response) {
      if (response.statusCode == 200) {
        if (success != null) {
          success(response.data);
        }
      } else {
        int code = response.statusCode;
        String msg = response.statusMessage;
        if (error == null) {
          Fluttertoast.showToast(msg: "服务器开小差了");
        } else {
          error(code, msg);
        }
      }
    });
  }
}
