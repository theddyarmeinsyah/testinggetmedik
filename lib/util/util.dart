import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medik/function/anim/color_loader.dart';
// import 'package:medik/function/dialog_function.dart';
// import 'package:elma/function/http_function1.dart';
// import 'package:elma/widgetGlobal/alert_dialog_widget.dart';
// import 'package:package_info/package_info.dart';
// import 'package:html/parser.dart' show parse;
// import 'package:url_launcher/url_launcher.dart';
import 'package:exif/exif.dart';
import 'package:image/image.dart' as img;

class AppColors {
  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFFAFAFC);
  static const Color primaryColor = Color(0xFFDF8100);
  static const Color secondaryColor = Color(0xFFFF9607);
  static const Color darkText = Color(0xFF535353);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color grey = Color(0xFFEEEEEE);
  static const Color blue = Color(0xFF737DFF);
  static const Color red = Color(0xFFFF7070);
  static const Color nearlyBlue = Color(0xFF17ead9);
  static const Color pink = Color(0xFFF56E98);
  static const Color green = Color(0xFF0BD132);
  static const Color green1 = Color(0xFF9BE231);
  static const Color yellow = Color(0xFFF7FF00);
  static const Color defaultShadow = Color(0xFF757575);
}

class AppString {
  static const String fontName = 'Gotham';
  static const String fontNameNumber = 'Nunito';
}

final Widget loadingImg = ColorLoader2(
  color1: new Color(0xFFDF8300),
  color2: new Color(0xFFDF8300),
  color3: new Color(0xFFDF8300),
);

final Widget loadingScreenImg = ColorLoader2(
  color1: new Color(0xFFDF8300),
  color2: new Color(0xFFDF8300),
  color3: new Color(0xFFDF8300),
);

class Widgets {
  static Widget backWidget(BuildContext context) => new Expanded(
        flex: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeHorizontal * 2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
                Navigator.of(context).pop();
              },
              child: new Image.asset(
                'assets/images/back.png',
                height: SizeConfig.blockSizeHorizontal * 8.5,
              ),
            ),
          ),
        ),
      );

  static Widget backWidget2(BuildContext context) => new Expanded(
        flex: 10,
        child: ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(SizeConfig.blockSizeHorizontal * 2),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/Login');
              },
              child: Image.asset(
                'assets/images/back.png',
                height: SizeConfig.blockSizeHorizontal * 8.5,
              ),
            ),
          ),
        ),
      );
}

void openDialog({
  BuildContext context,
  String message,
  String thumbnail,
  String text,
  Function onClick,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: <Widget>[
              Container(
                width: SizeConfig.screenWidth,
                margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.blockSizeHorizontal * 6.0,
                ),
                padding: EdgeInsets.only(
                  bottom: SizeConfig.blockSizeHorizontal * 15.0,
                  left: SizeConfig.blockSizeHorizontal * 6.0,
                  right: SizeConfig.blockSizeHorizontal * 6.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(
                    Radius.circular(SizeConfig.blockSizeHorizontal * 5.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: SizeConfig.blockSizeHorizontal * 3.0,
                        offset: Offset(0.0, 0.75))
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 3.0,
                    ),
                    Image(
                      image: AssetImage(thumbnail != null
                          ? thumbnail
                          : StaticParameter.helpThumbnail),
                      height: SizeConfig.blockSizeHorizontal * 10.0,
                    ),
                    SizedBox(
                      height: SizeConfig.blockSizeHorizontal * 2.5,
                    ),
                    Text(
                      message != null
                          ? message
                          : 'Periksa kembali koneksi Wifi atau kuota internet Anda, dan silahkan coba kembali',
                      style: TextStyle(
                        fontFamily: AppString.fontName,
                        fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   top: SizeConfig.blockSizeHorizontal * 2.0,
              //   bottom: SizeConfig.blockSizeHorizontal * 2.0,
              //   left: SizeConfig.blockSizeHorizontal * 6.0,
              //   child: Container(
              //     width: SizeConfig.blockSizeHorizontal * 2.0,
              //     decoration: BoxDecoration(
              //       color: AppColors.red,
              //       borderRadius: BorderRadius.only(
              //         topLeft:
              //             Radius.circular(SizeConfig.blockSizeHorizontal * 4.5),
              //         bottomLeft:
              //             Radius.circular(SizeConfig.blockSizeHorizontal * 4.5),
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                bottom: SizeConfig.blockSizeHorizontal * 2.0,
                left: SizeConfig.blockSizeHorizontal * 8.0,
                right: SizeConfig.blockSizeHorizontal * 8.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(SizeConfig.blockSizeHorizontal * 3.0),
                      ),
                      child: Material(
                        color: AppColors.secondaryColor,
                        child: InkWell(
                          onTap: () {
                            onClick();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 5.0,
                              right: SizeConfig.blockSizeHorizontal * 3.0,
                              top: SizeConfig.blockSizeHorizontal * 2.5,
                              bottom: SizeConfig.blockSizeHorizontal * 2.5,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  text != null ? text : 'OK',
                                  style: TextStyle(
                                    color: AppColors.darkText,
                                    fontFamily: AppString.fontName,
                                    fontSize:
                                        SizeConfig.blockSizeHorizontal * 3.2,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  width: SizeConfig.blockSizeHorizontal * 2.5,
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
        ],
      ),
    ),
  );
}

List<T> mapping<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class FunctionValidate {
  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Email belum sesuai';
    else
      return null;
  }

  String validateName(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z,-.']+$");
    if (value.length == 0) {
      return "Nama belum diisi";
    } else if (value.length < 3) {
      return "Nama minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Nama mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validateTanggalLahir(String value) {
    if (value == 'Pilih Tanggal') {
      return "Tanggal lahir belum dipilih";
    }
    return null;
  }

  String validateNIK(String value) {
    final validCharacters = RegExp(r"^[0-9]+$");
    if (value.length == 0) {
      return "NIK belum diisi";
    } else if (value.length < 16) {
      return "NIK minimum 16 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "NIK mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validateNoNPWP(String value) {
    final validCharacters = RegExp(r"^[0-9]+$");
    if (value.length == 0) {
      return "No NPWP belum diisi";
    } else if (value.length < 16) {
      return "No NPWP minimum 16 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "No NPWP mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validatePassword(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z 0-9]+$");
    if (value.length == 0) {
      return "Kata Sandi belum diisi";
    } else if (value.length < 6) {
      return "Kata Sandi minimum 6 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Kata Sandi mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validatePhoneNumber(String value) {
    if (value.length == 0) {
      return "Nomor Handphone belum diisi";
    } else if (value.length < 10) {
      return "Nomor Handphone minimum 10 digit";
    } else if (value.substring(0, 2) != '08' && value.substring(0, 2) != '62') {
      return "Kode depan No. Handphone hanya boleh \n08 dan 62";
    }
    return null;
  }

  String validateTempatLahir(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z,-.']+$");
    if (value.length == 0) {
      return "Tempat Lahir belum diisi";
    } else if (value.length < 3) {
      return "Tempat Lahir minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Tempat Lahir karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validateNamaIbuKandung(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z,-.']+$");
    if (value.length == 0) {
      return "Nama ibu belum diisi";
    } else if (value.length < 3) {
      return "Nama ibu minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Nama ibu mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  // String validateAlamat(String value) {
  //   if (value.length == 0) {
  //     return "Alamat belum diisi";
  //   } else if (value.length < 3) {
  //     return "Alamat minimum 3 digit";
  //   }
  //   return null;
  // }

  String validateAlamat(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z 0-9,-.']+$");
    if (value.length == 0) {
      return "Alamat belum diisi";
    } else if (value.length < 3) {
      return "Alamat minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Alamat mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  Future<bool> checkKoneksi() async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  String validateKelurahan(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z 0-9,-.']+$");
    if (value.length == 0) {
      return "Kelurahan belum diisi";
    } else if (value.length < 3) {
      return "Kelurahan minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Kelurahan mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validateRt(String value) {
    final validCharacters = RegExp(r"^[0-9]+$");
    if (value.length == 0) {
      return "Rt belum diisi";
    } else if (value.length < 3) {
      return "Rt minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Rt mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }

  String validateRw(String value) {
    final validCharacters = RegExp(r"^[0-9]+$");
    if (value.length == 0) {
      return "Rw belum diisi";
    } else if (value.length < 3) {
      return "Rw minimum 3 digit";
    } else if (!validCharacters.hasMatch(value)) {
      return "Rw mengandung karakter yang tidak di perbolehkan";
    }
    return null;
  }
}

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double paddingTop;
  static double paddingBottom;
  static double screenWidth;
  static double screenHeight;
  static double blockSizeHorizontal;
  static double blockSizeVertical;

  static double _safeAreaHorizontal;
  static double _safeAreaVertical;
  static double safeBlockHorizontal;
  static double safeBlockVertical;

  static bool isTablet;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    paddingTop = _mediaQueryData.padding.top;
    paddingBottom = _mediaQueryData.padding.bottom;
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    
    isTablet = _mediaQueryData.size.shortestSide < 600 ? false : true;
  }
}

class StaticParameter {
  static bool isDev = true;
  static bool isUpdate = false;
  //static String baseUrl = 'https://karir.getmedik.co.id/api/prod'; //production
  static String baseUrl = 'https://karir.getmedik.co.id/api'; //dev
  //static String updateUrl = 'https://karir.getmedik.co.id/api/prod'; //production
  static String updateUrl = 'https://karir.getmedik.co.id/api'; //dev
  static String url;
  static String redirect = 'redirect';
  static String timeout = 'timeout';
  static String error = 'error';
  static String errorThumbnail = 'assets/images/error_close.png';
  static String alertThumbnail = 'assets/images/alert_close.png';
  static String helpThumbnail = 'assets/images/help_close.png';
  static String informationThumbnail = 'assets/images/information_close.png';
  static String authlogin = '/account/login';
  static String register = '/account/register';
}

Future<File> fixExifRotation(String imagePath) async {
  final originalFile = File(imagePath);
  List<int> imageBytes = await originalFile.readAsBytes();

  final originalImage = img.decodeImage(imageBytes);

  final height = originalImage.height;
  final width = originalImage.width;

  if (height >= width) {
    return originalFile;
  }

  final exifData = await readExifFromBytes(imageBytes);

  img.Image fixedImage;

  if (height < width) {
    // rotate
    if (exifData['Image Orientation'].printable.contains('Horizontal')) {
      fixedImage = img.copyRotate(originalImage, 90);
    } else if (exifData['Image Orientation'].printable.contains('180')) {
      fixedImage = img.copyRotate(originalImage, -90);
    } else {
      fixedImage = img.copyRotate(originalImage, 0);
    }
  }

  final fixedFile = await originalFile.writeAsBytes(img.encodeJpg(fixedImage));

  return fixedFile;
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class TooltipShapeBorder extends ShapeBorder {
  final double arrowWidth;
  final double arrowHeight;
  final double arrowArc;
  final double radius;

  TooltipShapeBorder({
    this.radius = 16.0,
    this.arrowWidth = 20.0,
    this.arrowHeight = 10.0,
    this.arrowArc = 0.0,
  }) : assert(arrowArc <= 1.0 && arrowArc >= 0.0);

  @override
  EdgeInsetsGeometry get dimensions => EdgeInsets.only(bottom: arrowHeight);

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) => null;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    rect = Rect.fromPoints(
        rect.topLeft, rect.bottomRight - Offset(0, arrowHeight));
    double x = arrowWidth, y = arrowHeight, r = 1 - arrowArc;
    return Path()
      ..addRRect(RRect.fromRectAndRadius(rect, Radius.circular(radius)))
      ..moveTo(rect.bottomCenter.dx + x / 2, rect.bottomCenter.dy)
      ..relativeLineTo(-x / 2 * r, y * r)
      ..relativeLineTo(-x / 2 * r, -y * r);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {}

  @override
  ShapeBorder scale(double t) => this;
}

final headerCircle = Image.asset(
  'assets/images/header_circle.png',
  height: SizeConfig.blockSizeHorizontal * 34,
);


class VerticalItem extends StatelessWidget {
  const VerticalItem({
    @required this.widgets,
    Key key,
  }) : super(key: key);

  final Widget widgets;

  @override
  Widget build(BuildContext context) => Container(
        height: 96,
        // child: Card(
        //   child: Text(
        //     '$title a long title',
        //     style: TextStyle(color: Theme.of(context).colorScheme.onSecondary),
        //   ),
        // ),
        child: widgets,
      );
}

class HorizontalItem extends StatelessWidget {
  const HorizontalItem({
    @required this.title,
    Key key,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) => Container(
        width: 140,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Material(
            color: Colors.white,
            child: Center(
              child: Text(
                title,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
        ),
      );
}

/// Wrap Ui item with animation & padding
Widget Function(
  BuildContext context,
  int index,
  Animation<double> animation,
) animationItemBuilder(
  Widget Function(int index) child, {
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      int index,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(0, -0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child(index),
            ),
          ),
        );

Widget Function(
  BuildContext context,
  Animation<double> animation,
) animationBuilder(
  Widget child, {
  double xOffset = 0,
  EdgeInsets padding = EdgeInsets.zero,
}) =>
    (
      BuildContext context,
      Animation<double> animation,
    ) =>
        FadeTransition(
          opacity: Tween<double>(
            begin: 0,
            end: 1,
          ).animate(animation),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: Offset(xOffset, 0.1),
              end: Offset.zero,
            ).animate(animation),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        );