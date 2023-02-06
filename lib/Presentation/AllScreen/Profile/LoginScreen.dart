import 'package:dante/Core/AppRoutes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
            children: [Container(),
              Text("Date With Purpose", style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold, color: Colors.red),),
              const SizedBox(height: 20.0),
              Text("And organize your suitors...", style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.brown),),
              const SizedBox(height: 100.0),
              Container(
                width: 280.0,
                child: TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              Container(
                width: 280,
                color: Colors.red,
                child: TextButton(
                  onPressed: () {
                    if(emailController.text.isEmpty){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("Please enter email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),));
                    }
                    else if (!emailController.text.contains("@")){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text("Please enter valid email", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),));
                    }
                    else{
                      Get.toNamed(AppRoutes.OTPSCREEN, arguments: "1234");
                    }
                  },
                  child: Text("Go", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                ),
              ),
              const SizedBox(height: 70.0),
              Text("Or continue with", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold, color: Colors.brown),),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child:
                    Image.asset("assets/applelogo.png", width: 30, height: 30, fit: BoxFit.cover, color: Colors.white,)),
                    ),
                  const SizedBox(width: 15.0),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(child:
                    Image.asset("assets/googlelogo.png", width: 25, height: 25, fit: BoxFit.cover, color: Colors.white,)),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
