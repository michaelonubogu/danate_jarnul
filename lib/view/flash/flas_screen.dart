import 'package:dante/boxs/boxs.dart';
import 'package:dante/controller/auth_controller/auth_controller.dart';
import 'package:dante/view/auth/ask_qustion/get_name.dart';
import 'package:dante/view/index.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../welcome/welcome.dart';

class FlashScreen extends StatefulWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2000), () {
      // 5s over, navigate to a new page
      getUserRedirect();
    });
  }

  var id;
  var take_info;
  var isVerify;
  getUserRedirect()async{
    var initalData = await AuthController.showInitData();
    //var login = await AuthController.showEmailVerify();
    // var box = await Hive.openBox("login");
   // var box = Boxes.getLogin.listenable();


    // print("===== this is box ${box.get("login_data")}");
     if(initalData != null && initalData["take_info"]){
        return Get.offAll(WelcomeScreen(), transition: Transition.rightToLeft);
    }else{
      return Get.to(WelcomeScreen(), transition: Transition.rightToLeft);
    }


  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: size.width,
          height: size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.mainColor,
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //flash logo
              SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.asset("assets/images/logo.png")),

              SizedBox(height: 10,),
              SizedBox(
                  width: size.width,
                  height: 300,
                  child: Image.asset("assets/images/flash_icon.png")),



            ],
          ),
        ),
      ),
    );
  }
}
