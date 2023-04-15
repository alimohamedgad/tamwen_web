import 'package:get_it/get_it.dart';
import 'package:tamwen_web/Featurs/Controller/Login_Cubit/login_cubit.dart';
import '../../Featurs/Controller/Flour_Cubit/flour_cubit.dart';
import '../../Featurs/Controller/People_Cubit/client_cubit.dart';
import '../../Featurs/Controller/Product_cubit/product_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  init() {
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => ClientCubit());
    getIt.registerFactory(() => ProductCubit());
    getIt.registerFactory(() => FlourCubit());
  }
}
