import 'package:get_it/get_it.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Flour_Cubit/flour_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Login_Cubit/login_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Tamwen_Cubit/tamwen_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  init() {
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => TamwenCubit());
    getIt.registerFactory(() => ProductCubit());
    getIt.registerFactory(() => FlourCubit());
  }
}
