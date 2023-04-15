import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Controller/Login_Cubit/login_cubit.dart';
import 'package:tamwen_web/Featurs/Controller/People_Cubit/client_cubit.dart';
import 'package:tamwen_web/Core/Services/utils.dart';
import 'package:tamwen_web/Featurs/View/Screens/Home/home_page.dart';
import 'Featurs/Controller/Flour_Cubit/flour_cubit.dart';
import 'Featurs/Controller/Product_cubit/product_cubit.dart';
import 'Core/Responsive/Device/info_widget.dart';
import 'Core/Get_it/get_it.dart';
import 'Core/Responsive/Device/device_model.dart';
import 'Core/Theme/theme_light.dart';
import 'Featurs/Data/Web_Services/Remote_Data_Source/auth_services.dart';
import 'Featurs/View/Screens/auth/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  ServiceLocator().init();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('ar')],
      fallbackLocale: const Locale('ar'),
      path: 'assets/translate',
      child: const TamwenApp(),
    ),
  );
}

class TamwenApp extends StatelessWidget {
  const TamwenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) => getIt<ClientCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => getIt<LoginCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => getIt<ProductCubit>(),
          ),
          BlocProvider(
            create: (BuildContext context) => getIt<FlourCubit>(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey: Utils.messengerKey,
          debugShowCheckedModeBanner: false,
          theme: themeDataLight(),
          home: InfoWidget(
            widgetInfo: (BuildContext context, DeviceInfoModel deviceInfo) {
              return user == null ? const LoginScreen() : const HomePage();
            },
          ),
        ),
      ),
    );
  }
}
