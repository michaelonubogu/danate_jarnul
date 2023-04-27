import 'package:dante/boxs/boxs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sizer/sizer.dart';

import '../../controller/auth_controller/auth_controller.dart';
import '../../utility/app_colors.dart';
import 'edit_profile.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool status = false;

  Future? showProfileFuture;
  //EMAIL
  var userid, email, isVerify;
   showProfile()async{
     var loginRes = await Boxes.getLogin.get("user");
     // setState(() {
     //   userid = loginRes["id"];
     //   email = loginRes["email"];
     //   isVerify = loginRes["isVerified"];
     // });
    var res = await Boxes.getProfile.get("profile_info");
    print("this is profile === ${loginRes?.email}");
    print("this is profile === ${res}");
    if(res != null){
      return res;
    }else{
      return Get.to(EditProfile());
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showProfileFuture = showProfile();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      //profile app bar 
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text("Profile",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textColor,
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: 7, bottom: 7),
            width: 40, height: 40,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
              onPressed: ()=>Get.to(EditProfile(), transition: Transition.rightToLeft),
              icon: Icon(IconlyLight.edit,),
            ),
          )
        ],
      ),
      
      //profile body 
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(30),
        child: Column(
          children: [
            //profile image section
            FutureBuilder(
              future: showProfileFuture,
              builder: (context,AsyncSnapshot<dynamic> snapshot) {
               if(snapshot.connectionState == ConnectionState.waiting){
                 return Container(
                   width: size.width,
                   padding: EdgeInsets.all(30),
                   height: 30.h,
                   decoration: BoxDecoration(
                       color: AppColors.white
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      CircularProgressIndicator(color: AppColors.mainColor, strokeWidth: 4,)
                     ],
                   ),
                 );
               }else if(snapshot.hasData){
                 return snapshot.data["user_id"] == userid ?
                  Container(
                   width: size.width,
                   padding: EdgeInsets.all(30),
                   height: 30.h,
                   decoration: BoxDecoration(
                       color: AppColors.white
                   ),
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       ClipRRect(
                         borderRadius: BorderRadius.circular(10),
                         child: Image.memory(Uint8List.fromList(snapshot.data["profile"]), height: 120, width: 120, fit: BoxFit.cover),
                       ),
                       SizedBox(height: 20,),
                       Text("${snapshot.data["f_name"]} ${snapshot.data["l_name"]}",
                         style: TextStyle(
                             fontSize: 15,
                             color: AppColors.textColor,
                             fontWeight: FontWeight.w600
                         ),
                       ),
                       SizedBox(height: 10,),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           Icon(Icons.date_range, color: AppColors.mainColor,),
                           SizedBox(width: 10,),
                           Text("January 15",
                             style: TextStyle(
                                 fontSize: 13,
                                 color: AppColors.textColor,
                                 fontWeight: FontWeight.w400
                             ),
                           ),
                         ],
                       )
                     ],
                   ),
                 ):buildEditProfile(size);
               }else{
                 return buildEditProfile(size);
               }
              }
            ),

            Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                children: [

                  buildProfileItems(
                    image: "assets/icons/info.png",
                    title: "Notification",
                    isTrailing: true,
                  ),
                  buildProfileItems(
                    image: "assets/icons/baloon.png",
                    title: "Relationships Goals",
                  ),
                  buildProfileItems(
                    image: "assets/icons/info.png",
                    title: "About Us",
                  ),
                  buildProfileItems(
                    image: "assets/icons/privacy.png",
                    title: "Privacy",
                  ),
                  buildProfileItems(
                    image: "assets/icons/logout.png",
                    title: "Logout",
                    onClick: ()async{
                      var data = {
                        "id" : userid,
                        "email" : email,
                        "isVerified" : isVerify,
                        "data" : "${DateTime.now()}",
                        "isLogin" : false,
                      };
                      AuthController.logout(data,context);
                    }
                  )


                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container buildEditProfile(Size size) {
    return Container(
                 width: size.width,
                 padding: EdgeInsets.all(30),
                 height: 30.h,
                 decoration: BoxDecoration(
                     color: AppColors.white
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   crossAxisAlignment: CrossAxisAlignment.center,
                   children: [
                     ClipRRect(
                       borderRadius: BorderRadius.circular(10),
                       child: Image.asset("assets/images/profile.jpeg", height: 120, width: 120,),
                     ),
                     SizedBox(height: 20,),
                     Text("Edit Your Profile",
                       style: TextStyle(
                           fontSize: 15,
                           color: AppColors.textColor,
                           fontWeight: FontWeight.w600
                       ),
                     ),
                     SizedBox(height: 10,),
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(Icons.date_range, color: AppColors.mainColor,),
                         SizedBox(width: 10,),
                         Text("January 15",
                           style: TextStyle(
                               fontSize: 13,
                               color: AppColors.textColor,
                               fontWeight: FontWeight.w400
                           ),
                         ),
                       ],
                     )
                   ],
                 ),
               );
  }

  Container buildProfileItems(
  {required String image, required String title, bool isTrailing = false, VoidCallback? onClick } ) {
    return Container(
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.white
                  ),
                  child: ListTile(
                    onTap: onClick,
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      width: 55, height: 55,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.blue.withOpacity(0.3)
                      ),
                      child: Image.asset("$image",
                        height: 20, width: 20,
                      ),
                    ),
                    title: Text("$title",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor
                      ),
                    ),
                    trailing: isTrailing ? Container(
                      width: 40.0,
                      margin: EdgeInsets.only(right: 20),
                      child: FlutterSwitch(
                        activeColor: AppColors.blue,
                        padding: 2,
                        width: 40.0,
                        height: 20.0,
                        valueFontSize: 5.0,
                        toggleSize: 15.0,
                        value: status,
                        borderRadius: 30.0,

                        // showOnOff: true,
                        onToggle: (val) {
                          setState(() {
                            status = val;
                          });
                        },
                      ),
                    ):SizedBox(),
                  ),
                );
  }


}
