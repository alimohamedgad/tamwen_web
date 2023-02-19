import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Flour_Cubit/flour_cubit.dart';
import 'package:tamwen_web/Featurs/Presention/Cubits/Tamwen_Cubit/tamwen_cubit.dart';
import 'Featurs/Core/app_colors.dart';
import 'Featurs/Core/utils.dart';
import 'Featurs/Presention/Cubits/Login_Cubit/login_cubit.dart';
import 'Featurs/Presention/Cubits/Product_cubit/product_cubit.dart';
import 'Featurs/Presention/Screens/DetailsScreen/details_screen.dart';
import 'Featurs/Presention/Screens/HomeScreen/home_page.dart';
import 'Featurs/Presention/Screens/LoginScreen/login_screen.dart';
import 'Featurs/Presention/Screens/test.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TamwenApp());
}

class TamwenApp extends StatelessWidget {
  const TamwenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => TamwenCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => LoginCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => ProductCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => FlourCubit(),
        ),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: Utils.messengerKey,
        debugShowCheckedModeBanner: false,
        theme: themeDataLight(),
        initialRoute: LoginScreen.id,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ar', ''),
        ],
        routes: {
          HomePage.id: (context) => HomePage(),
          LoginScreen.id: (context) => const LoginScreen(),
          DetailsScreen.idRouter: (context) => const DetailsScreen(),
          MyWidget.id: (context) => MyWidget(),
        },
      ),
    );
  }
}

ThemeData themeDataLight() {
  return ThemeData(
    scaffoldBackgroundColor: AppColors.primaryColor4,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryColor4,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: const TextTheme(),
  );
}
