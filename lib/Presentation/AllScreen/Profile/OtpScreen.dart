import 'package:dante/Core/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otp = Get.arguments;
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();
  FocusNode _focusNode4 = FocusNode();
  TextEditingController field1 = TextEditingController();
  TextEditingController field2 = TextEditingController();
  TextEditingController field3 = TextEditingController();
  TextEditingController field4 = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(),
              Text("Enter Email Code", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.red),),
              Image.asset("assets/otpimaage.png", height: 200.0, width: 200.0,),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 60, width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.0)
                    ),
                    child: TextFormField(
                      focusNode: _focusNode1,
                      onChanged: (value) {
                        if (value.length == 1) {
                          print(field1.text);
                          FocusScope.of(context).requestFocus(_focusNode2);
                        }
                      },
                      style: TextStyle(fontSize: 20.0, color: Colors.green, fontWeight: FontWeight.bold),
                      controller: field1,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "",
                        counterStyle: TextStyle(fontSize: 0.0),
                        border: InputBorder.none,
                        // hintText: "0",
                        hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Container(height: 60, width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.0)
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.green, fontWeight: FontWeight.bold),
                      focusNode: _focusNode2,
                      onChanged: (value) {
                        if (value.length == 1) {
                          print(field2.text);
                          FocusScope.of(context).requestFocus(_focusNode3);
                        }
                        else if (value.length == 0) {
                          FocusScope.of(context).requestFocus(_focusNode1);
                        }
                      },
                      controller: field2,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "",
                        counterStyle: TextStyle(fontSize: 0.0),
                        border: InputBorder.none,
                        // hintText: "0",
                        hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Container(height: 60, width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.0)
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.green, fontWeight: FontWeight.bold),
                      focusNode: _focusNode3,
                      onChanged: (value) {
                        if (value.length == 1) {
                          print(field3.text);
                          FocusScope.of(context).requestFocus(_focusNode4);
                        }
                        else if (value.length == 0) {
                          FocusScope.of(context).requestFocus(_focusNode2);
                        }
                      },
                      controller: field3,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "",
                        counterStyle: TextStyle(fontSize: 0.0),
                        border: InputBorder.none,
                        // hintText: "0",
                        hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.0,),
                  Container(height: 60, width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.0)
                    ),
                    child: TextFormField(
                      style: TextStyle(fontSize: 20.0, color: Colors.green, fontWeight: FontWeight.bold),
                      focusNode: _focusNode4,
                      onChanged: (value) {
                        if (value.length == 1) {
                          print(field4.text);
                          print(field1.text + field2.text + field3.text + field4.text);
                          if (field1.text + field2.text + field3.text + field4.text == otp) {
                            Get.toNamed(AppRoutes.HOMESCREEN);
                          }
                          else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("Incorrect OTP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),));
                          }
                        }
                        else if (value.length == 0) {
                          FocusScope.of(context).requestFocus(_focusNode3);
                        }
                      },
                      controller: field4,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        counterText: "",
                        counterStyle: TextStyle(fontSize: 0.0),
                        border: InputBorder.none,
                        // hintText: "0",
                        hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40.0),
              Container(
                width: 250,
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    if (field1.text + field2.text + field3.text + field4.text == otp) {
                      Get.toNamed(AppRoutes.HOMESCREEN);
                    }
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("Incorrect OTP", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),));
                    }
                  },
                  child: Text("Verify", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
