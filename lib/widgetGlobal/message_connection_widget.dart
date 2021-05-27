import 'package:medik/util/util.dart';
import 'package:flutter/material.dart';

class MessageConncection extends StatelessWidget {
  MessageConncection({@required this.message});
  final String message;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 6.0),
          topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 6.0),
        ),
      ),
      height: SizeConfig.blockSizeHorizontal * 110,
      padding: EdgeInsets.only(
        top: SizeConfig.paddingTop,
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
            height: SizeConfig.blockSizeHorizontal * 2.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
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
    );
  }

  void showModal(BuildContext context, String message) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: false,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.blockSizeHorizontal * 6.0),
              topRight: Radius.circular(SizeConfig.blockSizeHorizontal * 6.0),
            ),
          ),
          height: SizeConfig.blockSizeHorizontal * 110,
          padding: EdgeInsets.only(
            top: SizeConfig.paddingTop,
            
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
                height: SizeConfig.blockSizeHorizontal * 2.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
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
        );
      },
    );
  }
}

