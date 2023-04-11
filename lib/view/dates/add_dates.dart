import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utility/app_colors.dart';


class AddDates extends StatefulWidget {
  const AddDates({Key? key}) : super(key: key);

  @override
  State<AddDates> createState() => _AddDatesState();
}

class _AddDatesState extends State<AddDates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
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
          title: Text("Add Profile",
            style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor
            ),
          )
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            

          ],
        ),
      ),
    );
  }
}
