import 'package:elrond/screens/splash/splash_screen.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PARAM.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CryptoViewModel()),
        ],
        child: Builder(builder: (context) {
          AppSetting.sTop = MediaQuery.of(context).padding.top;
          AppSetting.sBottom = MediaQuery.of(context).padding.bottom;
          AppSetting.sScreenHeight = MediaQuery.of(context).size.height;
          AppSetting.sScreenWidth = MediaQuery.of(context).size.width;

          return MaterialApp(
            title: 'Elrond',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF1A1C2B),
              appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.transparent,
                  toolbarHeight: 0,
                  elevation: 0),
              useMaterial3: false,
            ),
            home: const SplashScreen(),
          );
        }),
      ),
    );
  }
}
