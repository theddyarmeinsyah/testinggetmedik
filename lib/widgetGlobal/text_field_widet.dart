import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';

class TextBoxField extends StatelessWidget {
  TextBoxField({@required this.title, this.controller, this.focusnode, this.functionchange, this.tooltip, this.textinput});
  final String title;
  final TextEditingController controller;
  final FocusNode focusnode;
  final Function functionchange;
  final String tooltip;
  final TextInputType textinput;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          this.title,
          style: titleStyle,
        ),
        Container(
          width: SizeConfig.safeBlockHorizontal * 120,//widthField,
          height: SizeConfig.safeBlockHorizontal * 12,//heightField,
          child: TextFormField(
            style: fieldFontSize,
            maxLength: 50,
            controller: controller,
            focusNode: focusnode,
            onChanged: functionchange,
            // keyboardType: TextInputType.emailAddress,
            keyboardType: textinput,
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
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  tooltip == null
                      ? SizedBox()
                      : Padding(
                          padding: iconPadding,
                          child: Tooltip(
                            message: tooltip,
                            child: iconError,
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
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
    bottom: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1.8 : 3),
    top: SizeConfig.blockSizeHorizontal * (SizeConfig.isTablet ? 1.8 : 3),
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