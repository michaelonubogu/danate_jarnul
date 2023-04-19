import '../../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utility/app_button.dart';
import 'ask_qustion/get_name.dart';

class VerifySuccess extends StatefulWidget {
  const VerifySuccess({Key? key}) : super(key: key);

  @override
  State<VerifySuccess> createState() => _VerifySuccessState();
}

class _VerifySuccessState extends State<VerifySuccess> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:AppColors.bgColor,
          body: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h, width: size.width,
                  child: Image.asset("assets/images/email_verified.png", fit: BoxFit.cover,),
                ),

                SizedBox(height: 6.h,),
                Text("Email Verified!",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                    fontSize: 30,
                  )
                ),
                SizedBox(height: 6.h,),

                AppButton(
                  onClick: ()=>Get.offAll(GetName(), transition: Transition.rightToLeft), //rout the next login pages
                  size: size,
                  child: Text("Continue",
                    style: TextStyle(
                        fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
