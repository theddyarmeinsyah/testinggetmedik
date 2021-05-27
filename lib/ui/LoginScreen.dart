import 'dart:convert';
import 'package:medik/function/anim/color_loader.dart';
import 'package:medik/function/config/http_function.dart';
import 'package:medik/function/dialog_function.dart';
import 'package:medik/provider/TaskProvider.dart';
import 'package:medik/ui/RegisterScreen.dart';
import 'package:medik/util/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class LoginScreen extends StatefulWidget {
  final String apiBaseUrl;
  LoginScreen({
    Key key,
    @required this.apiBaseUrl,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  final FunctionValidate functionValidate = new FunctionValidate();

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final PanelController panelController = new PanelController();
  final FocusNode emailFocusNode = new FocusNode();
  final FocusNode passwordFocusNode = new FocusNode();

  DateTime currentBackPressTime;
  double _borderRadius = SizeConfig.blockSizeHorizontal * 8.0;
  bool _isHideKataSandi = true;
  bool _showClose = false;

  String _tooltipPassword;
  String _tooltipEmail;
  bool ok = true;  
  

  bool update;

  @override
  void initState() {
    checkKoneksi();
    super.initState();
  } 

  void checkKoneksi() async {
    await Future.delayed(const Duration(milliseconds: 500)).then((_) async {
        resetData();
        // ignore: deprecated_member_use
        KeyboardVisibility.onChange.listen(
          (bool visible) {
            if (visible && panelController.isPanelClosed) {
              _showClose = true;
              panelController.open();
              changeRadius(0);
            } else if (!visible && panelController.isPanelOpen) {
              _showClose = false;
              panelController.close();
              changeRadius(radiusOn);
            }
          },
        );
    });
  }

  void resetData() async {
    await Future.delayed(const Duration(milliseconds: 100));
  }

  initEmail() {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('email') != null) {
        setState(() {
          emailController.text = prefs.getString('email');
        });
      }
    });
  }

  void showModal(String message) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      context: context,
      isDismissible: false,
      builder: (context) {
        return GestureDetector(
          onVerticalDragStart: (_) {},
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 6.0),
                topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 6.0),
              ),
            ),
            height: SizeConfig.blockSizeHorizontal * 100,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 8.0,
                ),
                Image(
                  image: AssetImage('assets/images/offline.png'),
                  height: SizeConfig.blockSizeHorizontal * 54.0,
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 4.0,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                    Flexible(
                      child: Text(
                        'Periksa kembali koneksi Wifi atau kuota internet Anda, dan silahkan coba kembali',
                        style: TextStyle(
                          fontFamily: AppString.fontName,
                          fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                          color: AppColors.darkText,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 4.0,
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.blockSizeHorizontal * 3.0,
                ),

                Padding(
                padding: const EdgeInsets.only(top:16.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.blockSizeHorizontal * 3.0),
                      ),
                      child: Material(
                        color: AppColors.grey,
                        child: InkWell(
                          onTap: () {
                            // onNegative();
                            // SystemSettings.system();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: SizeConfig.blockSizeHorizontal * 6.0,
                              vertical: SizeConfig.blockSizeHorizontal * 2.5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Buka pengaturan',
                                  style: TextStyle(
                                    color: AppColors.darkText,
                                    fontFamily: AppString.fontName,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.blockSizeHorizontal * 3.0),
                      ),
                      child: Material(
                        color: AppColors.secondaryColor,
                        child: InkWell(
                          onTap: () {
                            // onPositive();
                            checkKoneksi();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 5.0,
                              right: SizeConfig.blockSizeHorizontal * 3.5,
                              top: SizeConfig.blockSizeHorizontal * 2.5,
                              bottom: SizeConfig.blockSizeHorizontal * 2.5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Coba Lagi',
                                  style: TextStyle(
                                    color: AppColors.darkText,
                                    fontFamily: AppString.fontName,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 0.5,
                                ),
                                ImageIcon(
                                  AssetImage('assets/images/arrow_dot.png'),
                                  size: SizeConfig.blockSizeHorizontal * 4.0,
                                  color: AppColors.darkText,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),

              ],
            ),
          ),
        );
      },
    );
  }

  changeRadius(double radius) {
    setState(() {
      _borderRadius = radius;
    });
  }

  @override
  Widget build(BuildContext context) {
    var prefs =
        Provider.of<TaskProvider>(context, listen: false).getPreference;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Container(
        child: SlidingUpPanel(
          controller: panelController,
          maxHeight: SizeConfig.blockSizeVertical * 100 - SizeConfig.paddingTop,
          minHeight: SizeConfig.safeBlockVertical * 50 +
              SizeConfig.safeBlockVertical * 10.0,
          parallaxEnabled: true,
          parallaxOffset: .1,
          body: _body(),
          // panelBuilder: (sc) => _panel(),
          panelBuilder: (sc) => _panel(prefs),
          defaultPanelState: PanelState.CLOSED,
          isDraggable: false,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(_borderRadius),
            topRight: Radius.circular(_borderRadius),
          ),
        ),
      ),
    );
  }

  Widget _panel(SharedPreferences prefs) {
    return Container(
      alignment: Alignment.topCenter,
      color: Colors.transparent,
      padding: paddingPanel,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              _showClose
                  ? InkWell(
                      onTap: () {
                        if (emailFocusNode.hasFocus) {
                          emailFocusNode.unfocus();
                        }
                        if (passwordFocusNode.hasFocus) {
                          passwordFocusNode.unfocus();
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 18),
                        child: AnimatedContainer(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.8),
                            borderRadius: defaultBR,
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: SizeConfig.blockSizeHorizontal * 3.5,
                          ),
                          duration: Duration(milliseconds: 250),
                        ),
                      ),
                    )
                  : dynamicSB(5.5),
            ],
          ),
          Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: SizeConfig.blockSizeHorizontal *
                    (SizeConfig.isTablet ? 55 : 80),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockSizeHorizontal *
                            (SizeConfig.isTablet ? 2 : 3),
                        bottom: SizeConfig.blockSizeHorizontal *
                            (SizeConfig.isTablet ? 2 : 3),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          Container(
                            width: SizeConfig.isTablet ? 105 : 85,
                            height: SizeConfig.isTablet ? 3 : 2,
                            color: Colors.grey.withOpacity(0.4),
                          ),
                          Container(
                            width: SizeConfig.isTablet ? 40 : 30,
                            height: SizeConfig.isTablet ? 5 : 4,
                            color: AppColors.secondaryColor,
                          ),
                        ],
                      ),
                    ),
                    dynamicSB(3),
                    loginView(prefs),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget loginView(SharedPreferences prefs) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: SizeConfig.isTablet ? 12 : 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: defaultBR,
        boxShadow: defaultBoxShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          dynamicSB(SizeConfig.isTablet ? 8.5 : 6.5),
          Container(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 2.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Username',
                          style: titleStyle,
                        ),
                        paddingTitleField,
                        emailField(),
                        _tooltipEmail == null
                        ? SizedBox()
                        : Padding(
                            padding: iconPadding,
                            child: Container(
                              width: 220.0,
                              child: Text(
                                _tooltipEmail,
                                style: TextStyle(color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(
                      width: SizeConfig.isTablet ? 12 : 5,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Password',
                          style: titleStyle,
                        ),
                        paddingTitleField,
                        passwordField(),
                        _tooltipPassword == null
                        ? SizedBox()
                        : Padding(
                            padding: iconPadding,
                            child: Container(
                              width: 220.0,
                              child: Text(
                                _tooltipPassword,
                                style: TextStyle(color: Colors.red, fontSize: 12.0),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height:
                SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 3 : 5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              InkWell(
                child: Container(
                  width:
                      SizeConfig.screenWidth / (SizeConfig.isTablet ? 2.8 : 2) +
                          24,
                  height: SizeConfig.isTablet ? 60 : 36,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.green,
                        AppColors.green1
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.blue.withOpacity(0.3),
                        offset: Offset(0.0, 8.0),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        if (_next()) {
                          loginProcess(prefs, widget.apiBaseUrl);
                        }
                      },
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: AppString.fontName,
                                  fontWeight: FontWeight.w600,
                                  fontSize: SizeConfig.blockSizeHorizontal *
                                      (SizeConfig.isTablet ? 2.6 : 3.6),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            bottom: 0,
                            right: 16,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          dynamicSB(5),
          Container(
            alignment: Alignment.center,
            child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterScreen(apiBaseUrl: widget.apiBaseUrl),
                    ),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Tidak punya akun ? ",
                      style: normalColorTextStyle,
                      textAlign: TextAlign.end,
                    ),
                    Text(
                      " Daftar Sekarang",
                      style: normalColorTextStyleD,
                      textAlign: TextAlign.end,
                    ),
                  ],
                ),
            ),
          ),
          dynamicSB(5),
        ],
      ),
    );
  }

  SizedBox dynamicSB(double size) {
    return new SizedBox(
      height: SizeConfig.blockSizeHorizontal * size,
    );
  }

  Widget passwordField() {
    print(_tooltipPassword);
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          width: widthField,
          height: 45.0, //heightField,
          child: TextFormField(
            style: fieldFontSize,
            maxLength: 50,
            controller: passwordController,
            focusNode: passwordFocusNode,
            obscureText: _isHideKataSandi,
            keyboardType: TextInputType.text,
            onChanged: (val) {
              setState(() {
                _tooltipPassword = null;
              });
            },
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  borderSide: BorderSide(color: Colors.grey, width: 1),
                ),
                counter: SizedBox(),
                contentPadding: EdgeInsets.only(
                  top: SizeConfig.blockSizeHorizontal *
                      (SizeConfig.isTablet ? 0 : 1),
                  left: SizeConfig.blockSizeHorizontal + 1,
                ),
                suffixIcon: SizedBox()),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _isHideKataSandi = !_isHideKataSandi;
                  });
                },
                child: _isHideKataSandi
                    ? iconField(iconPassword)
                    : iconField(iconShowPassword),
              ),
            ],
          ),
        ),
        
      ],
    );
  }

  Widget emailField() {
    return Stack(
      alignment: Alignment.centerRight,
      children: <Widget>[
        Container(
          width: widthField,
          height: 45.0,//heightField,
          child: TextFormField(
            style: fieldFontSize,
            maxLength: 50,
            controller: emailController,
            focusNode: emailFocusNode,
            onChanged: (val) {
              setState(() {
                _tooltipEmail = null;
              });
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              counter: SizedBox(),
              contentPadding: fieldContentPadding,
              suffixIcon: SizedBox(),
            ),
          ),
        ),
      ],
    );
  }

  Widget iconField(Image image) {
    return Padding(
      padding: iconPadding,
      child: image,
    );
  }

  Widget iconWidget(String asset) {
    return Padding(
      padding: iconPadding,
      child: Image(
        image: AssetImage('assets/images/icon_password.png'),
        height:
            SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 3.2 : 4.2),
      ),
    );
  }

  void showing() {
    showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return new WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: ColorLoader2(
            color1: AppColors.secondaryColor,
            color2: AppColors.secondaryColor,
            color3: AppColors.secondaryColor,
          ),
        ),
      );
    });
  }

  Future loginProcess(SharedPreferences prefs, String apiBaseUrl) async {
    Dialogs.indicator(context);
    await Future.delayed(const Duration(milliseconds: 1500));
    checkKoneksi();    
    Map<String, dynamic> data = {
      "username": emailController.text, 
      "password": passwordController.text
    };
    insertPost(
      apiBaseUrl,
      data,
      StaticParameter.authlogin,
    ).then((response) async {
      await Future.delayed(const Duration(milliseconds: 100));
      Navigator.of(context).pop();
      if (response == StaticParameter.error) {
        showModal('message');
      } else if (response == StaticParameter.timeout) {
        Dialogs.show(
          context: context,
          message: 'Timeout, tidak dapat terhubung ke server',
          thumbnail: StaticParameter.errorThumbnail,
          text: 'OK',
          onClick: () {
            Navigator.of(context).pop();
          },
        );
      } else {
        try {
          Map<String, dynamic> resp = jsonDecode(response);
          String errorCode = resp['status'].toString();
          if (errorCode.toString() == "success") {
            Map<String, dynamic> data = resp['response'];
            print('cekdata' + data.toString());
            data.forEach((k, v) {
              if (k.toString() == 'token') {
                v.forEach((i, j) {
                  print(i);
                  print(j);
                });
                return;
              }
              prefs.setBool('logged_in', true);
              Navigator.pushReplacementNamed(context, '/Home');
            });          
          } else {
            Dialogs.show(
              context: context,
              message: resp['message'].toString().replaceAll('\\n', '\n') ??
                  'Tidak dapat login aplikasi',
              thumbnail: StaticParameter.errorThumbnail,
              text: 'OK',
              onClick: () {
                Navigator.of(context).pop();
              },
            );
          }
        } catch (_) {
          Dialogs.show(
            context: context,
            message: 'Terjadi kesalahan, tidak dapat login aplikasi!',
            thumbnail: StaticParameter.errorThumbnail,
            text: 'OK',
            onClick: () {
              Navigator.of(context).pop();
            },
          );
        }
      }
    });
  }

  Widget _body() {
    return Container(
      child: Column(children: [
        Padding(
            padding: EdgeInsets.only(
                top: SizeConfig.safeBlockVertical *
                    (SizeConfig.isTablet ? 14 : 15)),
            child: logo)
      ]),
    );
  }

  String validateName(String value) {
    setState(() {
      if (value.isEmpty)
        _tooltipEmail = 'Username belum diisi';
      else
        _tooltipEmail = null;
    });

    return _tooltipEmail;
  }

  String validatePassword(String value){
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    setState(() {
      if (value.isEmpty){
        _tooltipPassword = 'Password belum diisi';
      }else if (value.length < 6){
        _tooltipPassword = "Password minimum 6 digit";
      }else if (!regex.hasMatch(value)){
        _tooltipPassword = 'Password Min. 6 Char dengan kombinasi abjad dan angka';
      }
    });
    return _tooltipPassword;
  }

  bool _next() {
    String username = validateName(emailController.text);
    String password = validatePassword(passwordController.text);
    print(password);
    if (username == null && password == null) {
      return true;
    } else {
      return false;
    }
  }
}

const defaultBoxShadow = <BoxShadow>[
  BoxShadow(
    color: Colors.white,
    offset: Offset(1.0, 2.0),
    blurRadius: 8.0,
  ),
  BoxShadow(
    color: AppColors.defaultShadow,
    offset: Offset(1.0, 2.0),
    blurRadius: 8.0,
  ),
];

final titleStyle = TextStyle(
  color: AppColors.darkText,
  fontSize: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2.2 : 3.2),
  fontFamily: AppString.fontName,
  fontWeight: FontWeight.w600,
);

final logo = Image.asset(
  "assets/images/logoapp.png",
  height: SizeConfig.blockSizeHorizontal * 24,
  width: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 18 : 24),
);

final loginTitle = TextStyle(
  fontSize: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 3.0 : 4.8),
  fontFamily: AppString.fontName,
  fontWeight: FontWeight.w600,
);

final normalTextStyle = TextStyle(
  color: AppColors.darkText,
  fontSize: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2.2 : 3.4),
  fontFamily: AppString.fontName,
);

final normalColorTextStyle = TextStyle(
  color: AppColors.secondaryColor,
  fontWeight: FontWeight.w600,
  fontFamily: AppString.fontName,
  fontSize: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2.2 : 3.2),
);

final normalColorTextStyleD = TextStyle(
  color: AppColors.blue,
  fontWeight: FontWeight.w600,
  fontFamily: AppString.fontName,
  fontSize: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2.2 : 3.2),
);

final iconDaftar = Icon(
  Icons.arrow_forward,
  color: Colors.white,
  size: SizeConfig.isTablet ? 18 : 11,
);

final fieldContentPadding = EdgeInsets.only(
  top: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 0 : 1),
  bottom: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1 : 0),
  left: SizeConfig.blockSizeHorizontal + 1,
  right: SizeConfig.blockSizeHorizontal + 1,
);

final fieldFontSize = TextStyle(
  fontSize: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2.5 : 4),
  color: AppColors.lightText,
);

final iconPadding = EdgeInsets.only(
  bottom: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1.8 : 3),
);

final iconError = Icon(
  Icons.error,
  color: Colors.red,
  size: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 3.6 : 4.8),
);

final paddingTitleField = SizedBox(
  height: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1 : 0.6),
);

final focusedBorder = UnderlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(5.0)),
  borderSide: BorderSide(
    color: Colors.orangeAccent,
  ),
);

final widthField = SizeConfig.screenWidth / (SizeConfig.isTablet ? 3 : 2) +
    SizeConfig.blockSizeHorizontal * 11.0;

final heightField =
    SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 6 : 9);

final iconPassword = Image(
  image: AssetImage('assets/images/icon_password.png'),
  height: iconFieldSize,
);

final iconShowPassword = Image(
  image: AssetImage('assets/images/icon_show_password.png'),
  height: iconFieldSize,
);

final iconFieldSize =
    SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 3.2 : 4.2);

final defaultBR = BorderRadius.all(
  Radius.circular(12.0),
);

final paddingPanel = EdgeInsets.only(
    top: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 4 : 5));

final radiusOn = SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2 : 6);
