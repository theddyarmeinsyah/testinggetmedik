import 'dart:io';
import 'package:medik/db/dbconnproduct.dart';
import 'package:medik/function/dialog_function.dart';
import 'package:medik/model/product.dart';
import 'package:medik/util/util.dart';
import 'package:medik/widgetGlobal/text_field_widet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddData extends StatefulWidget {

  AddData({
    Key key,
  }) : super(key: key);
  @override
  _AddDataState createState() => new _AddDataState();
}

class _AddDataState extends State<AddData> {
  ProductModel user;
  _AddDataState({
    // ignore: unused_element
    Key key,
    this.user
  });

  DbConnProduct dbconn = DbConnProduct();
  int count;
  List<ProductModel> userList;
  
  TextEditingController _codeController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _stockController = new TextEditingController();
  
  final FocusNode codeFocusNode = new FocusNode();
  final FocusNode nameFocusNode = new FocusNode();
  final FocusNode priceFocusNode = new FocusNode();
  final FocusNode stockFocusNode = new FocusNode();
  
  String _tooltipCode;
  String _tooltipName;
  String _tooltipPrice;
  String _tooltipStock;

  @override
  void initState() {
    super.initState();
  }
  
  void insertsql(){
    final initDB = dbconn.initDB();
      initDB.then((db) async {
      dbconn.insertTransUser(ProductModel(
            code: int.parse(_codeController.text), 
            name: _nameController.text, 
            price: double.parse(_priceController.text),
            stock: double.parse(_stockController.text)
          )
        );
    });
  }
  void deletesql(){
     final initDB = dbconn.initDB();
      initDB.then((db) async {
        await dbconn.deleteTransuserSql(_codeController.text);
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                                  insertsql();
                                  // Navigator.of(context).pop();
                                  Navigator.pushReplacementNamed(context, '/Home');
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
                                'Save',
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
                                      Navigator.of(context).pop();
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
                                  'Add Task List Product',
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
                                title: 'Code Product',
                                controller: _codeController,
                                focusnode: codeFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipCode = null;
                                  });  
                                },
                                textinput: TextInputType.number,
                                tooltip: _tooltipCode,
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
                              ),
                              TextBoxField(
                                title: 'Nama Product',
                                controller: _nameController,
                                focusnode: nameFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipName = null;
                                  });  
                                },
                                textinput: TextInputType.name,
                                tooltip: _tooltipName,
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
                              ),
                              TextBoxField(
                                title: 'Price',
                                controller: _priceController,
                                focusnode: priceFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipPrice = null;
                                  });  
                                },
                                textinput: TextInputType.number,
                                tooltip: _tooltipPrice,
                              ),
                              SizedBox(
                                height: SizeConfig.blockSizeHorizontal * 3.0,
                              ),
                              TextBoxField(
                                title: 'Stock',
                                controller: _stockController,
                                focusnode: stockFocusNode,
                                functionchange: (val){
                                  setState((){
                                    _tooltipStock = null;
                                  });  
                                },
                                textinput: TextInputType.number,
                                tooltip: _tooltipStock,
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
        );
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

  String validateName(String value) {
    final validCharacters = RegExp(r"^[a-z A-Z,-.']+$");
    setState(() {
      if (value.length == 0)
        _tooltipName = "Nama belum diisi";
      else if (value.length < 3)
        _tooltipName = "Nama minimum 3 digit";
      else if (!validCharacters.hasMatch(value))
        _tooltipName = "Nama mengandung karakter yang tidak di perbolehkan";
      else
        _tooltipName = null;
    });
    return _tooltipName;
  }

  String validateCode(String value) {
    final validCharacters = RegExp(r"^[0-9]+$");
    setState(() {
      if (value.length == 0)
        _tooltipCode = "Code belum diisi";
      else if (value.length < 3)
        _tooltipCode = "Code minimum 3 digit";
      else if (!validCharacters.hasMatch(value))
        _tooltipCode = "Nama mengandung karakter yang tidak di perbolehkan";
      else
        _tooltipCode = null;
    });
    return _tooltipCode;
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

  bool _next() {
    String code = validateCode(_codeController.text);
    String name = validateName(_nameController.text);
    if (name == null &&
        code == null) {
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

}
