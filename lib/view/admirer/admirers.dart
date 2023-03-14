import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_profile.dart';

class Admirers extends StatefulWidget {
  const Admirers({Key? key}) : super(key: key);

  @override
  State<Admirers> createState() => _AdmirersState();
}

class _AdmirersState extends State<Admirers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        elevation: 0,
        centerTitle: true,
          title: Text("Admirers",
            style: TextStyle(
                fontSize: 18,
                color: Colors.black
            ),
          )
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddAdmirerProfile(), transition: Transition.rightToLeft);
          // Add your onPressed code here!
        },
        label: const Text('Add'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.mainColor,
      ),
    );
  }
}
