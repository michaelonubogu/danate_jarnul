import '/view/auth/ask_qustion/get_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../utility/app_button.dart';
import '../../../utility/app_colors.dart';
import '../../home/home.dart';
import 'niceto_meet.dart';

class Question extends StatefulWidget {
  const Question({Key? key}) : super(key: key);

  @override
  State<Question> createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: size.width,
                height: 20.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: size.width*.40,
                      child: Column(
                        children: [
                          SizedBox(height: 3.h,),
                          Text("Is this your first time dating?",
                            style: TextStyle(
                                wordSpacing: 0.9,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textColor
                            ),
                          ),
                          SizedBox(height: 3.h,),
                          Row(
                            children: [
                              Text("No",
                                style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.normalTxtColor
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 15, right: 15),
                                child: FlutterSwitch(
                                  padding: 4,
                                  width: 60.0,
                                  height: 30.0,
                                  valueFontSize: 10.0,
                                  toggleSize: 30.0,
                                  value: status,
                                  borderRadius: 30.0,

                                 // showOnOff: true,
                                  onToggle: (val) {
                                    setState(() {
                                      status = val;
                                    });
                                  },
                                ),
                              ),
                              Text("Yes",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500, color: AppColors.normalTxtColor
                                ),
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),

                    SizedBox(
                      width: size.width*.40,
                      child: Image.asset("assets/images/qus3_icon.png" ,height: 150, width: 100, fit: BoxFit.contain,),
                    )
                  ],
                ),
              ) ,
              SizedBox(height: 3.h,),
              Text("Why did your last relationship end?",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18, color: AppColors.textColor
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),

              SizedBox(height: 3.h,),
              Text("What type of partner are you looking for?",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18, color: AppColors.textColor
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),

              SizedBox(height: 3.h,),
              Text("What things would you contribute to your next relationship?",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18, color: AppColors.textColor
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                maxLines: 3,
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              SizedBox(height: 5.h,),
              AppButton(
                onClick: ()=>Get.to(Home(), transition: Transition.rightToLeft), //rout the next login pages
                size: size,
                child: Text("Next",
                  style: TextStyle(
                      fontSize: 15, color: Colors.white, fontWeight: FontWeight.w500
                  ),
                ),
              ), 
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: ()=>Get.to(GetName(), transition: Transition.leftToRight),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Skip",
                        style: TextStyle(
                          fontSize: 15, color: AppColors.normalTxtColor
                        ),
                      ),
                      Icon(Icons.double_arrow, color: AppColors.normalTxtColor, size: 17,)
                    ],
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
