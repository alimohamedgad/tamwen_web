import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Core/Responsive/Device/enums_device.dart';
import 'package:tamwen_web/Featurs/Core/Responsive/Device/info_widget.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Flour_Cubit/flour_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/People_Cubit/people_cubit.dart';
import 'Featurs/Core/Get_it/get_it.dart';
import 'Featurs/Core/Responsive/Device/device_model.dart';
import 'Featurs/Core/Theme/theme_light.dart';
import 'Featurs/Core/utils.dart';
import 'Featurs/Presention/Cubits/Login_Cubit/login_cubit.dart';
import 'Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'Featurs/Presention/Screens/Mobile/Login/login_screen.dart';
import 'Featurs/Presention/Screens/Web/LoginScreen_Web/login_web.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  ServiceLocator().init();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('ar')],
      fallbackLocale: const Locale('ar'),
      path: 'assets/translate',
      child: const TamwenApp()));
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
            create: (BuildContext context) => getIt<PeopleCubit>(),
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
          // builder: (context, child) => ResponsiveWrapper.builder(
          //   child,
          //   maxWidth: 1200,
          //   minWidth: 480,
          //   defaultScale: true,
          //   background: Container(color: const Color(0xFFF5F5F5)),
          //   breakpoints: [
          //     const ResponsiveBreakpoint.resize(480, name: MOBILE),
          //     const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          //     const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          //   ],
          // ),

          theme: themeDataLight(),
          home: InfoWidget(
            widgetInfo: (BuildContext context, DeviceInfoModel deviceInfo) {
              if (deviceInfo.deviceType == DeviceType.web) {
                return const LoginScreenWeb();
              } else if (deviceInfo.deviceType == DeviceType.tablet) {
                return const LoginScreen();
              } else {
                return const LoginScreen();
              }
            },
          ),
          // routes: {
          //   HomePage.id: (context) => HomePage(),
          //   LoginScreen.id: (context) => const LoginScreen(),
          //   DetailsScreen.idRouter: (context) => const DetailsScreen(),
          //   MyWidget.id: (context) => MyWidget(),
          // },
        ),
      ),
    );
  }
}
