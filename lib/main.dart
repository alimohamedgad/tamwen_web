import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tamwen_web/Featurs/Core/Get_it/get_it.dart';
import 'package:tamwen_web/Featurs/Core/Responsive/Responsive_Layout/responsive_layout.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Flour_Cubit/flour_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import 'Featurs/Core/Theme/theme_light.dart';
import 'Featurs/Core/utils.dart';
import 'Featurs/Presention/Cubits/Login_Cubit/login_cubit.dart';
import 'Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'Featurs/Presention/Screens/Mobile/Login/login_screen.dart';
import 'Featurs/Presention/Screens/Web/HomeScreen_Web/side_bar.dart';
import 'Featurs/Presention/Screens/Web/LoginScreen_Web/login_web.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  ServiceLocator().init();
  runApp(const TamwenApp());
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
            create: (BuildContext context) => getIt<TamwenCubit>(),
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
          scaffoldMessengerKey: Utils.messengerKey,
          debugShowCheckedModeBanner: false,
          theme: themeDataLight(),
          home: ResponsiveLayout(
            mobileWidget: LoginScreen(),
            webWidget: LoginScreenWeb(),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ar', ''),
          ],
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
