import 'package:medik/function/anim/color_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class IndicatorWidgetUpdate extends ModalRoute<void> {
  IndicatorWidgetUpdate();

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => Colors.black12;

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
    return Center(
      child: ColorLoader2(
        color1: new Color(0xFFDF8300),
        color2: new Color(0xFFDF8300),
        color3: new Color(0xFFDF8300),
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SpinKitThreeBounce(color: Colors.grey, size: 50.0, duration: const Duration(milliseconds: 800));
  }
}
