import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAdmirerProfile extends StatefulWidget {
  const AddAdmirerProfile({Key? key}) : super(key: key);

  @override
  State<AddAdmirerProfile> createState() => _AddAdmirerProfileState();
}

class _AddAdmirerProfileState extends State<AddAdmirerProfile> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.bgColor,
        centerTitle: true,
        leading: Container(
          margin: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: ()=>Get.back(),
            icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,),
          ),
        ),
        // leading: Container(
        //   width: 40, height: 40,
        //   margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
        //   decoration: BoxDecoration(
        //     color: Colors.grey.shade200,
        //     borderRadius: BorderRadius.circular(5),
        //   ),
        //   child: Center(child: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,)),
        // ),
        title: Text("Add Profile",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textColor
          ),
        )
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            // Container(
            //   width: size.width,
            //   height: 60,
            //   decoration: BoxDecoration(
            //     color: AppColors.bgColor,
            //   ),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 40, height: 40,
            //         padding: EdgeInsets.only(left: 12, right: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.grey.shade200,
            //           borderRadius: BorderRadius.circular(5),
            //         ),
            //         child: Center(child: Icon(Icons.arrow_back_ios, color: Colors.black,)),
            //       ),
            //       SizedBox(width: size.width*.25,),
            //       Text("Add Profile",
            //         style: TextStyle(
            //             fontSize: 20,
            //             fontWeight: FontWeight.w600,
            //             color: Colors.black
            //         ),
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
