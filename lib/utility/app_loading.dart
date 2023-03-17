import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppLoading{

  static Future appLoading({required BuildContext context})async{
   return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          buttonPadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          iconPadding: EdgeInsets.zero,
          titlePadding: EdgeInsets.zero,
          content: SizedBox(
            height: 50,
            child: Row(
              children: [
                SpinKitCircle(
                  color: AppColors.mainColor,
                  size: 50.0,
                ),
                SizedBox(width: 15,),
                Text("Loading..."),
              ],
            ),
          ),

        );
      },
    );
  }

}