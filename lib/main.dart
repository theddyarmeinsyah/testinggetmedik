import 'package:flutter/material.dart';
import 'package:medik/function/config/appconfig.dart';
import 'package:medik/provider/TaskProvider.dart';
import 'package:medik/ui/HomeScreen.dart';
import 'package:medik/ui/LoginScreen.dart';
import 'package:medik/ui/RegisterScreen.dart';
import 'package:medik/ui/SplashScreen.dart';
import 'package:medik/util/util.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  var configuredApp = new AppConfig(
    appName: 'Testing Medik',
    envName: 'development',
    apiBaseUrl: 'https://karir.getmedik.co.id/api/',
    child: MyApp(),
  );

  runApp(configuredApp);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  AnimationController animationController;
  
  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(milliseconds: 450), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskProvider(),
        ),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Testing Medik',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: Routes.getRoute(),
      ),
    );
  }
}

class Routes {
  static Map<String, WidgetBuilder> getRoute() {
    return <String, WidgetBuilder>{
      '/': (ctx) => Splashscreen(),
      '/Login': (ctx) => LoginScreen(apiBaseUrl: StaticParameter.baseUrl),
      '/Register': (ctx) => RegisterScreen(apiBaseUrl: StaticParameter.baseUrl),
      '/Home': (ctx) => HomeScreen(),
    };
  }
}
