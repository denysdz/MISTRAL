import 'package:elrond/screens/password/password_input_screen.dart';
import 'package:elrond/screens/splash/splash_screen.dart';
import 'package:elrond/settings/constants.dart';
import 'package:elrond/settings/param.dart';
import 'package:elrond/viewmodel/TransactionViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:elrond/viewmodel/CryptoViewModel.dart';


final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PARAM.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  DateTime? _backgroundTime;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _backgroundTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed) {
      if (_backgroundTime != null) {
        final timeInBackground = DateTime.now().difference(_backgroundTime!);
        if (timeInBackground.inSeconds >= 10) {
          if (PARAM.user != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              navigatorKey.currentState?.pushReplacement(
                MaterialPageRoute(builder: (context) => PasswordInputScreen()),
              );
            });
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CryptoViewModel()),
          ChangeNotifierProvider(create: (_) => TransactionViewModel()),
        ],
        child: Builder(builder: (context) {
          AppSetting.sTop = MediaQuery.of(context).padding.top;
          AppSetting.sBottom = MediaQuery.of(context).padding.bottom;
          AppSetting.sScreenHeight = MediaQuery.of(context).size.height;
          AppSetting.sScreenWidth = MediaQuery.of(context).size.width;

          return MaterialApp(
            //key: navigatorKey, // Assign the GlobalKey to MaterialApp
            navigatorKey: navigatorKey,
            title: 'Elrond',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: const Color(0xFF1A1C2B),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.transparent,
                toolbarHeight: 0,
                elevation: 0,
              ),
              useMaterial3: false,
            ),
            home: const SplashScreen(),
          );
        }),
      ),
    );
  }
}
