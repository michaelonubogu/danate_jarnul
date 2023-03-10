import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/auth/ask_qustion/question.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/app_button.dart';
import 'get_name.dart';



class NiceToMeet extends StatefulWidget {
  const NiceToMeet({Key? key}) : super(key: key);

  @override
  State<NiceToMeet> createState() => _NiceToMeetState();
}

class _NiceToMeetState extends State<NiceToMeet> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor:AppColors.bgColor,
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text("Nice to meet you Nayon!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.blue,
                      fontSize: 30,
                    )
                ),
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Text("We’re excited to embark on this awesome journey with you!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      wordSpacing: 0.9,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textColor
                  ),
                ),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 300, width: size.width,
                child: Image.asset("assets/images/qus2_icon.png", fit: BoxFit.contain,),
              ),

              SizedBox(height: 60,),
              Padding(
                padding: const EdgeInsets.only(left: 40, right: 40),
                child: Text("Next we’ll ask you a couple of questions to help you with your goals for dating.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      wordSpacing: 0.9,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                      color: AppColors.normalTxtColor
                  ),
                ),
              ),
              SizedBox(height: 60,),

              AppButton(
                onClick: ()=>Get.to(Question(), transition: Transition.rightToLeft), //rout the next login pages
                size: size,
                child: Text("Let's go",
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
