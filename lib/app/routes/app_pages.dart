import 'package:get/get.dart';
import 'package:zdm/app/modules/home/bindings/home_binding.dart';
import 'package:zdm/app/modules/home/views/home_view.dart';
import 'package:zdm/app/modules/root/bindings/root_binding.dart';
import 'package:zdm/app/modules/root/views/root_view.dart';
import 'package:zdm/app/modules/scanner/bindings/scanner_binding.dart';
import 'package:zdm/app/modules/scanner/views/scanner_view.dart';

part 'app_routes.dart';
final rootBinding = RootBinding();
class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;
  
  static final routes = [
    GetPage(
        name: '/',
        page: () => RootView(),
        binding: rootBinding,
        participatesInRootNavigator: true,
        preventDuplicates: true,
        children: [
          GetPage(
              preventDuplicates: true,
              name: _Paths.HOME,
              page: () => HomeView(),
              bindings: [
                rootBinding,
                HomeBinding()
              ]),
          GetPage(
              preventDuplicates: true,
              name: _Paths.SCANNER,
              page: () => ScannerView(),
              bindings: [
                rootBinding,
                ScannerBinding()
              ])
        ])
  ];
}
