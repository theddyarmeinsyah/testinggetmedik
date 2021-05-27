import 'package:medik/db/dbconnproduct.dart';
import 'package:medik/model/product.dart';
import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';

import 'editdata_screen.dart';

class DetailWidget extends StatefulWidget {
  DetailWidget(this.trans);

  final ProductModel trans;

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  _DetailWidgetState();

  DbConnProduct dbconn = DbConnProduct();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          children: [
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
                              Navigator.pushReplacementNamed(
                                        context, '/Home');
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
                          'Detail Data',
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
              child: Card(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: 440,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Code :',
                                    style: TextStyle(
                                        color:
                                            Colors.black.withOpacity(0.8))),
                                Text(widget.trans.code.toString(),
                                    style:
                                        Theme.of(context).textTheme.headline4)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Name :',
                                    style: TextStyle(
                                        color:
                                            Colors.black.withOpacity(0.8))),
                                Text(widget.trans.name,
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                          ),
                          dynamicSB(5),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Price :',
                                    style: TextStyle(
                                        color:
                                            Colors.black.withOpacity(0.8))),
                                Text(widget.trans.price.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                          ),
                          dynamicSB(5),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Stock :',
                                    style: TextStyle(
                                        color:
                                            Colors.black.withOpacity(0.8))),
                                Text(widget.trans.stock.toString(),
                                    style:
                                        Theme.of(context).textTheme.bodyText2)
                              ],
                            ),
                          ),
                          dynamicSB(5),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 24.0,
                                  height: SizeConfig.blockSizeHorizontal * 10.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.green,
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        _navigateToEditScreen(
                                            context, widget.trans);
                                      },
                                      child: Text('Edit',
                                          style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                ),
                                dynamicSB(5),
                                Container(
                                  width: SizeConfig.blockSizeHorizontal * 24.0,
                                  height: SizeConfig.blockSizeHorizontal * 10.0,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: InkWell(
                                      onTap: () {
                                        _confirmDialog();
                                      },
                                      child: Text('Delete',
                                          style: TextStyle(color: Colors.white)),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox dynamicSB(double size) {
    return new SizedBox(
      height: SizeConfig.blockSizeHorizontal * size,
    );
  }

  final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.black87,
  minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
);

  _navigateToEditScreen(BuildContext context, ProductModel trans) async {
    print(trans);
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditDataWidget(trans)),
    );
  }

  Future<void> _confirmDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Warning!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want delete this item?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                final initDB = dbconn.initDB();
                initDB.then((db) async {
                  await dbconn.deleteTransuser(widget.trans.id);
                });
                Navigator.pushReplacementNamed(context, '/Home');
              },
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
