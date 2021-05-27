import 'package:flutter/material.dart';
import 'package:medik/util/util.dart';

class AlertDialogWidget extends ModalRoute<void> {
  String message;
  String thumbnail;
  String positiveMessage;
  String negativeMessage;
  Function onPositive;
  Function onNegative;

  AlertDialogWidget({
    this.message,
    this.thumbnail,
    this.positiveMessage,
    this.negativeMessage,
    this.onPositive,
    this.onNegative,
  });

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black38;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return Material(
      type: MaterialType.transparency,
      child: SafeArea(
        child: _buildOverlayContent(context),
      ),
    );
  }

  Widget _buildOverlayContent(BuildContext context) {
    return Column(
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
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(SizeConfig.blockSizeHorizontal * 5.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
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
                    height: SizeConfig.blockSizeHorizontal * 3.0,
                  ),
                  Text(
                    message != null ? message : 'Periksa kembali koneksi Wifi atau kuota internet Anda, dan silahkan coba kembali',
                    style: TextStyle(
                      fontFamily: AppString.fontName,
                      fontSize: SizeConfig.blockSizeHorizontal * 3.6,
                      fontWeight: FontWeight.w600,
                      color: AppColors.darkText,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: SizeConfig.blockSizeHorizontal * 2.0,
              left: SizeConfig.blockSizeHorizontal * 12.0,
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
                      color: AppColors.grey,
                      child: InkWell(
                        onTap: () {
                          onNegative();
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
                                negativeMessage != null
                                    ? negativeMessage
                                    : 'Tidak',
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
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4.0,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(SizeConfig.blockSizeHorizontal * 3.0),
                    ),
                    child: Material(
                      color: AppColors.secondaryColor,
                      child: InkWell(
                        onTap: () {
                          onPositive();
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
                                positiveMessage != null
                                    ? positiveMessage
                                    : 'Ya',
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
      ],
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}
