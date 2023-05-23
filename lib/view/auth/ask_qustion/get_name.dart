import 'dart:math';
import '../../../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import '../../../utility/app_button.dart';
import 'niceto_meet.dart';


class GetName extends StatefulWidget {
  const GetName({Key? key}) : super(key: key);

  @override
  State<GetName> createState() => _GetNameState();
}

class _GetNameState extends State<GetName> {


  final name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor:AppColors.bgColor,
          body: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.h, width: size.width,
                  child: Image.asset("assets/images/qusition.png", fit: BoxFit.contain,),
                ),

                SizedBox(height: 6.h,),
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
                SizedBox(height: 6.h,),
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
                  controller: name,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter your name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none
                      )
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return "Field must not be empty!";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 6.h,),

                AppButton(
                  onClick: ()async{

                    //reDirect Next Page
                    if(name.text.isNotEmpty){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>NiceToMeet(name: name.text,)));
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Filed must not be empty!"),
                        backgroundColor: Colors.red,
                        duration: Duration(milliseconds: 3000),
                      ));
                    }
                  },
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
      ),
    );
  }
}
