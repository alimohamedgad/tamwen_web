import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Core/Services/utils.dart';
import 'features/Controller/Login_Cubit/login_cubit.dart';
import 'Core/Theme/theme_light.dart';
import 'Core/firebase_const.dart';
import 'features/Controller/Flour_Cubit/flour_cubit.dart';
import 'features/Controller/People_Cubit/client_cubit.dart';
import 'features/Controller/Product_cubit/product_cubit.dart';
import 'features/View/Screens/Home/home_page.dart';
import 'features/View/Screens/auth/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
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
            create: (BuildContext context) => ClientCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => ProductCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => LoginCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) => FlourCubit(),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          scaffoldMessengerKey: Utils.messengerKey,
          debugShowCheckedModeBanner: false,
          theme: themeDataLight(),
          // home: LoginScreen(),
          home: user == null ? const LoginScreen() : const HomePage(),
        ),
      ),
    );
  }
}
