import 'package:dante/controller/auth_controller/sent_opt.dart';

import '../../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../utility/app_button.dart';
import 'verify_email.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  //text editing controller
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h, width: size.width,
                child: Image.asset("assets/images/confirm_email_icon.png"),
              ),
              SizedBox(height: 3.h,),
              Text("Confirm Your E-mail Address",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16, color: AppColors.textColor
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 280,
                child: Text("We’ll send you a verification code so we can verify your email.",
                  style: TextStyle(
                      wordSpacing: 0.9,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.normalTxtColor
                  ),
                ),
              ),
              SizedBox(height: 6.h,),
              Text("E-mail",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18, color: AppColors.textColor
                ),
              ),
              SizedBox(height: 2.h,),
              TextFormField(
                controller: email,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "johan@gmail.com",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                  )
                ),
              ),
              SizedBox(height: 6.h,),

              AppButton(
                onClick: ()=>SendOtp.sendOTP(context: context, email: email.text), //rout the next login pages
                size: size,
                child: Text("Next",
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
