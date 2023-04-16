import 'package:get_it/get_it.dart';
import '../../features/Controller/Flour_Cubit/flour_cubit.dart';
import '../../features/Controller/Login_Cubit/login_cubit.dart';
import '../../features/Controller/Product_cubit/product_cubit.dart';
import '../../features/controller/People_Cubit/client_cubit.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  init() {
    getIt.registerFactory(() => LoginCubit());
    getIt.registerFactory(() => ClientCubit());
    getIt.registerFactory(() => ProductCubit());
    getIt.registerFactory(() => FlourCubit());
  }
}
