import 'package:flutter/material.dart';

import '../../../utility/app_button.dart';
import '../../../utility/app_colors.dart';
class ShowAdmirerPopup{

//this method show the popup for add social media
  static Future showAdmirerPopup(size, context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                titlePadding: EdgeInsets.zero,
                iconPadding: EdgeInsets.zero,
                buttonPadding: EdgeInsets.zero,
                insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),

                actionsPadding: EdgeInsets.zero,
                // contentPadding: EdgeInsets.all(10),
                content: SingleChildScrollView(
                  child: ListBody(
                    children:  <Widget>[
                      Text('Choose media',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: AppColors.blue
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: AppColors.blue, width: 1)
                        ),

                      ),

                      SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppButton(
                            onClick: ()=>Navigator.pop(context), //rout the next login pages
                            size: size*.25,
                            bg: Colors.grey.shade300,
                            child: Text("Cancel",
                              style: TextStyle(
                                  fontSize: 15, color:AppColors.textColor, fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          AppButton(
                            onClick: (){

                              Navigator.pop(context);
                            }, //rout the next login pages
                            size: size*.25,
                            child: Text("Save",
                              style: TextStyle(
                                  fontSize: 15, color:AppColors.white, fontWeight: FontWeight.w500
                              ),
                            ),
                          )
                        ],
                      ),

                      SizedBox(height: 10,),

                    ],
                  ),
                ),

              );
            }
        );
      },
    );
  }

}