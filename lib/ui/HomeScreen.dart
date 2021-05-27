import 'package:fluttertoast/fluttertoast.dart';
import 'package:medik/LocalStorage/adddata_screen.dart';
import 'package:medik/LocalStorage/translist_widget.dart';
import 'package:medik/db/dbconnproduct.dart';
import 'package:medik/model/product.dart';
import 'package:medik/provider/TaskProvider.dart';
import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';
import 'package:medik/widgetGlobal/alert_dialog_widget.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DbConnProduct dbconn = DbConnProduct();
  List<ProductModel> transList;
  int totalCount = 0;
  DateTime currentBackPressTime;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    var prefs =
        Provider.of<TaskProvider>(context, listen: false).getPreference;
    if(transList == null) {
      // ignore: deprecated_member_use
      transList = List<ProductModel>();
    }
    return WillPopScope(
      child: Scaffold(
        body: new Container(
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
                          flex: 80,
                          child: Container(
                            padding: EdgeInsets.all(
                                SizeConfig.blockSizeHorizontal * 2.0),
                            margin: EdgeInsets.only(
                              left: SizeConfig.blockSizeHorizontal * 3.0,
                              right: SizeConfig.blockSizeHorizontal * 16.0,
                            ),
                            child: Text(
                              'Task List',
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
                                      message:
                                          'Apakah Anda yakin ingin keluar dari sistem ini!!!',
                                      positiveMessage: "Ya",
                                      onNegative: () {
                                        Navigator.of(context).pop();
                                      },
                                      onPositive: () {
                                        Navigator.of(context).pop();
                                        prefs.setBool('logged_in', false);
                                        Navigator.pushReplacementNamed(
                                            context, '/Login');
                                      },
                                    ),
                                  );
                                },
                                child: Icon(
                                    Icons.logout,
                                    color: Colors.black,
                                    size: SizeConfig.blockSizeHorizontal * 6.5,
                                ),
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
                child: new FutureBuilder(
                  future: loadList(),
                  builder: (context, snapshot) {
                    return transList.length > 0 
                    ? new TransList(trans: transList)
                    :  new Center(child: new Text('', style: Theme.of(context).textTheme.headline6));
                  },
                )
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed:() {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddData()),
            );
          },
          tooltip: 'Add Task',
          child: Icon(Icons.add),
        ), 
      ),
      onWillPop: () => onWillPopScope());
  }

  Future<bool> onWillPopScope() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: 'Tekan sekali lagi untuk keluar');
      return Future.value(false);
    }
    return Future.value(true);
  }

  Future loadList() {
    final Future futureDB = dbconn.initDB();
    return futureDB.then((db) {
      Future<List<ProductModel>> futureTrans = dbconn.transuser();
      futureTrans.then((transList) {
        setState(() {
          this.transList = transList;
        });
      });
    });
  }

  // Returns the priority color
	Color getPriorityColor(int priority) {
		switch (priority) {
			case 1:
				return Colors.red;
				break;
			case 2:
				return Colors.yellow;
				break;

			default:
				return Colors.yellow;
		}
	}

	// Returns the priority icon
	Icon getPriorityIcon(int priority) {
		switch (priority) {
			case 1:
				return Icon(Icons.play_arrow);
				break;
			case 2:
				return Icon(Icons.keyboard_arrow_right);
				break;

			default:
				return Icon(Icons.keyboard_arrow_right);
		}
	}
}
