import '../../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utility/app_button.dart';
import '../auth/login.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Padding(
          padding: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 20),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor
                  ),
                ),
                SizedBox(height: 2.h,),
                SizedBox(
                  width: 280,
                  child: Text("Where every date is a new chapter in your love story. Document your journey to finding your person, one date at a time.!",
                    style: TextStyle(
                        wordSpacing: 0.9,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: AppColors.normalTxtColor
                    ),
                  ),
                ),


                SizedBox(height: 10.h,),
                SizedBox(
                  width: size.width,
                  height: 30.h,
                  child: Image.asset("assets/images/welcome_icon.png", fit: BoxFit.cover,),
                ),
                SizedBox(height: 10.h,),
                AppButton(
                  onClick: ()=>Get.to(Login(), transition: Transition.rightToLeft), //rout the next login pages
                    size: size,
                    child: Text("Get Started",
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

