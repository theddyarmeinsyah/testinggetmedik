import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';

class UpdateDialogWidget extends ModalRoute<void> {
  String message;
  String thumbnail;
  String text;
  Function onClick;

  UpdateDialogWidget(
    this.message,
    this.thumbnail,
    this.text,
    this.onClick,
  );

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
      child: WillPopScope(
          child: SafeArea(
            child: _buildOverlayContent(context),
          ),
          onWillPop: () async => false),
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
                    message != null
                        ? message
                        : 'Periksa kembali koneksi Wifi atau kuota internet Anda, dan silahkan coba kembali',
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
                          onClick != null
                              ? onClick()
                              : Navigator.of(context).pop();
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
