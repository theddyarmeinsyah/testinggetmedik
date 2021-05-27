import 'dart:convert';
import 'dart:io';
import 'package:medik/db/dbconnproduct.dart';
import 'package:medik/function/config/http_function.dart';
import 'package:medik/function/dialog_function.dart';
import 'package:medik/model/product.dart';
import 'package:medik/util/util.dart';
import 'package:medik/widgetGlobal/text_field_widet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:medik/widgetGlobal/alert_dialog_widget.dart';

class RegisterScreen extends StatefulWidget {
  final String apiBaseUrl;
  RegisterScreen({
    Key key,
    @required this.apiBaseUrl,
  }) : super(key: key);
  @override
  _RegisterScreenState createState() => new _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  DbConnProduct dbconn = DbConnProduct();
  int count;
  List<ProductModel> userList;
  DateTime currentBackPressTime;
  
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  final FocusNode usernameFocusNode = new FocusNode();
  final FocusNode passwordFocusNode = new FocusNode();
  final FocusNode passwordFocusNode1 = new FocusNode();
  final FocusNode emailFocusNode = new FocusNode();
  
  String _tooltipUsername;
  String _tooltipPassword;
  String _tooltipPassword1;
  String _tooltipEmail;

  @override
  void initState() {
    super.initState();
  }
  
  Future registerProcess(String apiBaseUrl) async {
    Dialogs.indicator(context);
    await Future.delayed(const Duration(milliseconds: 1500));
    checkKoneksi();    
    Map<String, dynamic> data = {
      "username": _usernameController.text,       
      "password": _passwordController.text,
      "email": _emailController.text,
    };
    insertPost(
      apiBaseUrl,
      data,
      StaticParameter.register,
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
            Navigator.pushReplacementNamed(context, '/Login');
          } else {
            Dialogs.show(
              context: context,
              message: resp['message'].toString().replaceAll('\\n', '\n') ??
                  'Tidak dapat register aplikasi',
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
            message: 'Terjadi kesalahan, tidak dapat register aplikasi!',
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
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
          bottomNavigationBar: Container(
            color: Colors.white,
            width: SizeConfig.screenWidth,
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom,
            ),
            height: SizeConfig.blockSizeHorizontal * 16.0 +
                MediaQuery.of(context).padding.bottom,
            child: Column(
              children: [
                Container(
                  color: Colors.grey.withOpacity(0.3),
                  height: SizeConfig.blockSizeHorizontal * 0.2,
                ),
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(),
                      ),
                      InkWell(
                        onTap: () {
                            if (_next()) {
                            Dialogs.show(
                              context: context,
                              message: 'Apakah Anda yakin ingin menyimpan data ini',
                              thumbnail: StaticParameter.informationThumbnail,
                              text: 'OK',
                              onClick: () {
                                  Navigator.of(context).pop();
                                  registerProcess(widget.apiBaseUrl);
                              },
                            );
                            }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.blockSizeHorizontal * 3.0,
                            vertical: SizeConfig.blockSizeHorizontal * 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                  SizeConfig.blockSizeHorizontal * 2.0),
                            ),
                          ),
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 5.0,
                              ),
                              Text(
                                'Add',
                                style: TextStyle(
                                  color: new Color(0xFF535353),
                                  fontFamily: AppString.fontName,
                                  fontSize:
                                      SizeConfig.blockSizeHorizontal * 3.6,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                width: SizeConfig.blockSizeHorizontal * 4.0,
                              ),
                              ImageIcon(
                                AssetImage('assets/images/arrow_dot.png'),
                                size: SizeConfig.blockSizeHorizontal * 5.0,
                                color: new Color(0xFF535353),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 6.0,
                      ),                     
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Container(
            color: new Color(0xFFD4D4D4),
            child: Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight:
                      Radius.circular(SizeConfig.blockSizeHorizontal * 9.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 4.0,
                      right: SizeConfig.blockSizeHorizontal * 3.0,
                      top: SizeConfig.blockSizeHorizontal * 3.0,
                      bottom: SizeConfig.blockSizeHorizontal * 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/bg_1.png',
                        ),
                        fit: BoxFit.fitWidth,
                      ),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(
                            SizeConfig.blockSizeHorizontal * 9.0),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Stack(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              flex: 10,
                              child: ClipRRect(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      SizeConfig.blockSizeHorizontal * 2),
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        AlertDialogWidget(
                                          message: 'Apakah Anda yakin ingin membatalkan proses registrasi',
                                          positiveMessage: "Ya",
                                          onNegative: () {
                                            Navigator.of(context).pop();
                                          },
                                          onPositive: () {
                                            Navigator.of(context).pop();
                                            Navigator.pushReplacementNamed(context, '/Login');
                                          },
                                        ),
                                      );
                                    },
                                    child: Image.asset(
                                      'assets/images/close.png',
                                      color: AppColors.darkText,
                                      height:
                                          SizeConfig.blockSizeHorizontal * 8.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 80,
                              child: Container(
                                padding: EdgeInsets.all(
                                    SizeConfig.blockSizeHorizontal * 2.0),
                                margin: EdgeInsets.only(
                                  left: SizeConfig.blockSizeHorizontal * 3.0,
                                  right: SizeConfig.blockSizeHorizontal * 16.0,
                                ),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                    fontFamily: AppString.fontName,
                                    color:
                                        AppColors.darkerText.withOpacity(0.9),
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 4.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.only(
                            top: SizeConfig.blockSizeHorizontal * 3.4,
                            left: SizeConfig.blockSizeHorizontal * 7.0,
                            right: SizeConfig.blockSizeHorizontal * 7.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 5.0,
                              ),
                              TextBoxField(
                                title: 'Username',
                                controller: _usernameController,
                                focusnode: usernameFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipUsername = null;
                                  });  
                                },
                                tooltip: null,
                              ),
                              _tooltipUsername == null
                              ? SizedBox()
                              : Padding(
                                  padding: iconPadding,
                                  child: Container(
                                    width: 220.0,
                                    child: Text(
                                      _tooltipUsername,
                                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
                              ),
                              TextBoxField(
                                title: 'Password',
                                controller: _passwordController,
                                focusnode: passwordFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipPassword = null;
                                  });  
                                },
                                tooltip: null,
                              ),
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
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
                              ),
                              TextBoxField(
                                title: 'Re-Type Password',
                                controller: _passwordController1,
                                focusnode: passwordFocusNode1,
                                functionchange: (val){
                                  setState((){
                                    _tooltipPassword1 = null;
                                  });  
                                },
                                tooltip: null,
                              ),
                              _tooltipPassword1 == null
                              ? SizedBox()
                              : Padding(
                                  padding: iconPadding,
                                  child: Container(
                                    width: 220.0,
                                    child: Text(
                                      _tooltipPassword1,
                                      style: TextStyle(color: Colors.red, fontSize: 12.0),
                                    ),
                                  ),
                                ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
                              ),
                              TextBoxField(
                                title: 'Email',
                                controller: _emailController,
                                focusnode: emailFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipEmail = null;
                                  });  
                                },
                                tooltip: null,
                              ),
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
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
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
          ),
        ),
      onWillPop: () => onWillPopScope(),
    );
  }

  Future<bool> onWillPopScope() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    Navigator.of(context).push(
      AlertDialogWidget(
        message: 'Apakah Anda yakin ingin membatalkan proses registrasi',
        positiveMessage: "Ya",
        onNegative: () {
          Navigator.of(context).pop();
        },
        onPositive: () {
          Navigator.of(context).pop();
          Navigator.pushReplacementNamed(context, '/Login');
        },
      ),
    );
    return Future.value(true);
  }

  // ignore: missing_return
  Future<bool> checkKoneksi() async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch(_) {
      return false;
    }
  }

  

  final titleStyle = TextStyle(
    fontFamily: AppString.fontName,
    color: AppColors.secondaryColor,
    fontSize: SizeConfig.blockSizeHorizontal * 3.6,
  );

  final contentTextFieldPadding = EdgeInsets.only(
    left: SizeConfig.blockSizeHorizontal * 0.5,
    top: SizeConfig.blockSizeHorizontal * 3.0,
  );

  String validateName(String value) {
    Pattern pattern = r'^(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    setState(() {
      if (value.length == 0){
        _tooltipUsername = "Nama belum diisi";
      }else if (value.length < 3){
        _tooltipUsername = "Nama minimum 3 digit";
      }else if (!regex.hasMatch(value)){
        _tooltipUsername = "Nama Min. 6 Char dengan kombinasi abjad dan angka";
      }
    });
    return _tooltipUsername;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    setState(() {
      if (value.isEmpty){
        _tooltipEmail = 'Email belum diisi';
      }else if (!regex.hasMatch(value)){
        _tooltipEmail = 'Email belum sesuai';
      }
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

  String validatePassword1(String value){
    Pattern pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
    RegExp regex = new RegExp(pattern);
    setState(() {
      print('cek1' + _passwordController.text);
      print('cek2' + _passwordController1.text);
      if (value.isEmpty){
        _tooltipPassword1 = 'Password belum diisi';
      }else if (value.length < 6){
        _tooltipPassword1 = "Password minimum 6 digit";
      }else if (!regex.hasMatch(value)){
        _tooltipPassword1 = 'Password Min. 6 Char dengan kombinasi abjad dan angka';
      }else if (_passwordController.text != _passwordController1.text){
        _tooltipPassword1 = 'Re-Type Password tidak sama Password';
      }
    });
    return _tooltipPassword1;
  }

  
  bool _next() {
    String name = validateName(_usernameController.text);
    String email = validateEmail(_emailController.text);
    String password = validatePassword(_passwordController.text);
    String password1 = validatePassword1(_passwordController1.text);

    if (name == null && 
        email == null && 
        password == null &&
        password1 == null) {
      return true;
    } else {
      return false;
    }
  }

  void moveToLastScreen() {
		Navigator.pop(context, true);
  }

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
    bottom: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1.8 : 0.5),
    top: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1.8 : 0.5),
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

  final widthField = SizeConfig.screenWidth / (SizeConfig.isTablet ? 1 : 1) +
      SizeConfig.blockSizeHorizontal * 3.0;

  final heightField =
      SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 6 : 9);

  final iconPassword = Image(
    image: AssetImage('assets/images/icon_password.png'),
  );

  final iconShowPassword = Image(
    image: AssetImage('assets/images/icon_show_password.png'),
  );

  final iconFieldSize =
      SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 3.2 : 4.2);

  final defaultBR = BorderRadius.all(
    Radius.circular(12.0),
  );

  final paddingPanel = EdgeInsets.only(
      top: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 4 : 5));

  final radiusOn = SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 2 : 6);

}
