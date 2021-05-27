import 'package:medik/provider/TaskProvider.dart';
import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashscreen extends StatefulWidget {
  Splashscreen({
    Key key,
  }) : super(key: key);

  @override
  _SplashscreenState createState() => new _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    nextScreen();
  }

  Future nextScreen() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getBool('logged_in') != null && prefs.getBool('logged_in')) {
        Navigator.pushReplacementNamed(context, '/Home');
      } else {
        Navigator.pushReplacementNamed(context, '/Login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Color(0xFF000000),
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    SizeConfig().init(context);
    Provider.of<TaskProvider>(context, listen: false).initPreference();
    return Scaffold(
      body: Container(
        color: HexColor('#FFFFFF'),
        child: Center(
          child: Image(
            image: AssetImage(
              'assets/images/logoapp.png',
            ),
            height: SizeConfig.blockSizeHorizontal *
                (SizeConfig.isTablet ? 16 : 24),
          ),
        ),
      ),
    );
  }
 
  @override
  void dispose() {
    super.dispose();
  }
}