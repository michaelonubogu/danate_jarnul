import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utility/app_button.dart';
import 'niceto_meet.dart';


class GetName extends StatefulWidget {
  const GetName({Key? key}) : super(key: key);

  @override
  State<GetName> createState() => _GetNameState();
}

class _GetNameState extends State<GetName> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor:AppColors.bgColor,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300, width: size.width,
                child: Image.asset("assets/images/qusition.png", fit: BoxFit.contain,),
              ),

              SizedBox(height: 60,),
              Text("Hey!",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                    fontSize: 25,
                  )
              ),
              SizedBox(height: 10,),
              Text("Tell us how to address you !",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: AppColors.normalTxtColor,
                    fontSize: 16,
                  )
              ),
              SizedBox(height: 60,),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("This Dating Journal belongs to...?",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17, color: AppColors.textColor
                  ),
                ),
              ),
              SizedBox(height: 15,),
              TextFormField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Enter your name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none
                    )
                ),
              ),
              SizedBox(height: 60,),

              AppButton(
                onClick: ()=>Get.to(NiceToMeet(), transition: Transition.rightToLeft), //rout the next login pages
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
