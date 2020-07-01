import 'package:checkcar/route/page_routes.dart';
import 'package:fluro/fluro.dart';

class PageRouter {
  static final router = Router();

  static setupRoutes() {
    pageRoutes.forEach((path, handler) {
      router.define(
          path, handler: handler.getHandler(),
          transitionType: TransitionType.inFromRight);
    });
  }
}