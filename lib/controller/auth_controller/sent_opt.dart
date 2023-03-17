import 'package:dante/config/app_config.dart';
import 'package:dante/view/auth/verify_email.dart';
import 'package:dante/view/auth/verify_success.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../utility/app_loading.dart';

class SendOtp{


  // otp send method
  // now we can use this method anywhere in our project. its take 2 parameters.
  static Future sendOTP({required BuildContext context,  required String email})async{
    AppLoading.appLoading(context: context);
    EmailOTP myauth = EmailOTP();
    myauth.setConfig(
        appEmail: AppConfig.APP_MAIL,
        appName: "Dante - Digital Dating Journal: Verify you email. ",
        userEmail: "$email",
        otpLength: 5,
        otpType: OTPType.digitsOnly
    );
    print("otp send response ===== ${myauth.sendOTP}");
    if(await myauth.sendOTP() == true){//if otp sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
        content: Text('OTP Send Your Email.'),
      ));
      Navigator.pop(context);
      //redirect otp verification page
      Navigator.push(context, MaterialPageRoute(builder: (context)=>EmailVerify(myauth: myauth,)));
    }else{ //if otp not sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 3500),
        content: Text('OTP Not Send to your email. Please try again!'),
      ));
      Navigator.pop(context);
    }

  }


  //check otp
  // now we can use this method anywhere in our project. its take 2 parameters.
  static Future checkOTP({required BuildContext context,  required String otp,  required EmailOTP myauth})async{
    AppLoading.appLoading(context: context);
    var res =await myauth.verifyOTP(otp: otp);
    print("otp send response ===== ${myauth.sendOTP}");
    if(res){//if otp sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.green,
        duration: Duration(milliseconds: 3000),
        content: Text('Email Verified.'),
      ));
      //redirect otp verification page
      Get.to(VerifySuccess(), transition: Transition.leftToRight);

    }else{ //if otp not sent
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.red,
        duration: Duration(milliseconds: 3500),
        content: Text('OTP do not match. Please try again!'),
      ));
      Navigator.pop(context);
    }

  }

}