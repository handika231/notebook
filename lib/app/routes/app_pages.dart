import 'package:get/get.dart';

import '../modules/add_page/bindings/add_page_binding.dart';
import '../modules/add_page/views/add_page_view.dart';
import '../modules/edit_page/bindings/edit_page_binding.dart';
import '../modules/edit_page/views/edit_page_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAGE,
      page: () => const AddPageView(),
      binding: AddPageBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PAGE,
      page: () => EditPageView(),
      binding: EditPageBinding(),
    ),
  ];
}
