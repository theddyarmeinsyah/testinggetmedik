import 'package:medik/function/dialog_widget.dart';
import 'package:medik/function/indicator_widget_update.dart';
import 'package:flutter/material.dart';
import 'package:medik/function/update_dialog_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<void> show({
    BuildContext context,
    String message,
    String thumbnail,
    String text,
    Function onClick,
  }) {
    return Navigator.of(context).push(
      DialogWidget(message, thumbnail, text, onClick),
    );
  }

  
  static Future<void> showUpdateDialog({
    BuildContext context,
    String message,
    String thumbnail,
    String text,
    Function onClick,
  }) {
    return Navigator.of(context).push(
      UpdateDialogWidget(message, thumbnail, text, onClick),
    );
  }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  Widget indicatorreload() {
    return SpinKitRotatingCircle(
      color: Colors.white,
      size: 50.0,
    );
  }
  
  static Future<void> indicator(BuildContext context) {
    // return Navigator.of(context).push(
    //   IndicatorWidget(),
    // );
     return Navigator.of(context).push(
      IndicatorWidgetUpdate(),
    );
  }

  

  static Future<DialogAction> yesAbortDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset('assets/images/onboarding2.png',
                      width: 200.0, height: 200.0),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'poppins-Regular'),
                ),
              ],
            ),
          ),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'poppins-Regular'),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'poppins-Regular'),
                )),
            // RaisedButton(
            //   onPressed: () => Navigator.of(context).pop(DialogAction.yes),
            //   child: const Text('Yes', style: TextStyle(color: Colors.black)),
            // ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> simpan(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset('assets/images/onboarding2.png',
                      width: 200.0, height: 200.0),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'poppins-Regular'),
                ),
              ],
            ),
          ),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'poppins-Regular'),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'poppins-Regular'),
                )),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> popupMessagesStd(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'poppins-Regular'),
                ),
              ],
            ),
          ),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'poppins-Regular'),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'poppins-Regular'),
                )),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> passwordBerhasil(BuildContext context,
      String title, String body, Function fungtionmessage) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset('assets/images/berhasil.png',
                      width: 200.0, height: 200.0),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'poppins-Regular'),
                ),
              ],
            ),
          ),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'poppins-Regular'),
          ),
          actions: <Widget>[
            TextButton(
                //onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                onPressed: fungtionmessage,
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'poppins-Regular'),
                )),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }

  static Future<DialogAction> passwordTidakBerhasil(BuildContext context,
      String title, String body, Function fungtionmessage) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  child: Image.asset('assets/images/berhasil.png',
                      width: 200.0, height: 200.0),
                ),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontFamily: 'poppins-Regular'),
                ),
              ],
            ),
          ),
          content: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'poppins-Regular'),
          ),
          actions: <Widget>[
            TextButton(
                //onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                onPressed: fungtionmessage,
                child: const Text(
                  'Close',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontFamily: 'poppins-Regular'),
                )),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.abort;
  }
}