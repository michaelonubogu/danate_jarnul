import 'package:dante/boxs/boxs.dart';
import 'package:dante/view/auth/login.dart';
import 'package:dante/view/index.dart';
import 'package:shared_preferences/shared_preferences.dart';
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


  getUserRedirect()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get("token"); //get the token

    print("this is token ==== ${token}");
    List userToken = []; 

    if(token != null ){
      //show all login data
      for(var i = 0; i < Boxes.getLogin.length; i ++){
        //store data with index
        var data = Boxes.getLogin.getAt(i);
        print("this is user data ==== ${data?.email}");
        userToken.add(data?.token);
      }
      //check token
      if(userToken.contains(token)){
        print("========== user is exit =============");
        return Get.offAll(Index(), transition: Transition.rightToLeft);
      }else{
        print("========== user is not exit =============");
        return Get.offAll(Login(), transition: Transition.rightToLeft);
      }
    }else{
      return Get.offAll(WelcomeScreen(), transition: Transition.rightToLeft);
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
