import 'package:dante/controller/auth_controller/auth_controller.dart';
import 'package:dante/view/index.dart';

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
      Get.to(WelcomeScreen(), transition: Transition.rightToLeft);
    });
  }

  var id;
  var take_info;
  getUserRedirect()async{
    var res = await AuthController.showInitData();
    setState(() {
      id = res["id"];
      take_info = "take_info";
    });

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
