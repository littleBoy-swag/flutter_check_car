import 'package:checkcar/pages/big_image_page.dart';
import 'package:checkcar/pages/car_detail_page.dart';
import 'package:checkcar/route/page_builder.dart';

class RouteConstant {
  static final CAR_DETAIL_PAGE = "car_detail_page";
  static final BIG_IMAGE_PAGE = "big_image_page";
}

final Map<String, PageBuilder> pageRoutes = {
  RouteConstant.CAR_DETAIL_PAGE:
      PageBuilder(builder: (bundle) => CarDetailPage()),
  RouteConstant.BIG_IMAGE_PAGE:
      PageBuilder(builder: (bundle) => BigImagePage(bundle: bundle)),
};
