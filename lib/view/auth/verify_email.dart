import '../../utility/app_colors.dart';
import '../../view/auth/verify_success.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:sizer/sizer.dart';

import '../../utility/app_button.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
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
                child: Image.asset("assets/images/otp_icon.png"),
              ),
              SizedBox(height: 3.h,),
              Text("Enter Verification Code",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16, color: AppColors.textColor
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: 280,
                child: Text("Type the verification code we send to your e-mail.",
                  style: TextStyle(
                      wordSpacing: 0.9,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: AppColors.normalTxtColor
                  ),
                ),
              ),
              SizedBox(height: 6.h,),
              OTPTextField(
                length: 5,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 50,
                style: TextStyle(
                    fontSize: 17
                ),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  print("Completed: " + pin);
                },
              ),
              SizedBox(height: 15,),
              Center(
                child: RichText(text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Resent code in ",
                      style: TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.textColor
                      )
                    ),  TextSpan(
                        text: "51 s",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.blue
                        )
                    ),

                  ]
                )),
              ),
              SizedBox(height: 6.h,),

              AppButton(
                onClick: ()=>Get.to(VerifySuccess(), transition: Transition.rightToLeft), //rout the next login pages
                size: size,
                child: Text("Confirm",
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
