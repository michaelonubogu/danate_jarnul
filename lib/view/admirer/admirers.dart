import 'dart:typed_data';

import 'package:dante/database/local_database.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/admirer/single_admirers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../boxs/boxs.dart';
import '../../controller/auth_controller/auth_controller.dart';
import '../../model/admirers_model/admirers_model.dart';
import 'add_profile.dart';

class Admirers extends StatefulWidget {
  const Admirers({Key? key}) : super(key: key);

  @override
  State<Admirers> createState() => _AdmirersState();
}

class _AdmirersState extends State<Admirers> {
  var selectedIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLogedInUser();
  }

  //user auth
  var userToken;
  getLogedInUser()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     userToken = prefs.getString("token");
   });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          automaticallyImplyLeading: false,
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
      
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
              child: ValueListenableBuilder<Box<AdmirerModel>>(
                valueListenable: Boxes.getAdmirers.listenable(),
                builder: (context, box, _) {
                  var data = box.values.toList().cast<AdmirerModel>();

                  //empty admirer model list
                  List<AdmirerModel> shortedData = [];

                  for(var i in data){
                    if(i.userId == userToken.toString()){
                      shortedData.add(i);
                    }
                    print("this is token ==== ${i.userId}");
                    print("this is token ==== ${userToken}");
                  }



                  return shortedData.length != 0
                      ? AlphabetScrollView(
                   // list: AdmirersListJson.admirersList.map((e) => AlphaModel(e["name"])).toList(),
                    list: shortedData.map((e) => AlphaModel(e.admirerName)).toList(),
                    itemExtent: 150,
                    itemBuilder: (_, k, id) {
                      print("=== ${data.contains(data[k].userId)}===");
                      return  InkWell(
                        onTap: ()=>Get.to(SingleAdmirers(admirers: shortedData[k]), transition: Transition.rightToLeft),
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: ListTile(
                            //contentPadding: EdgeInsets.only(bottom: 20),
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(Uint8List.fromList(shortedData[k].profile) , height: 50, width: 50, fit: BoxFit.cover,)),

                            title: Text("${shortedData[k].admirerName}",
                              style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black
                              ),
                            ),
                            subtitle: Row(
                              children: [
                                Row(
                                  children: [
                                    shortedData[k].rate > 80.00
                                    ? Row(
                                      children: [
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                      ],
                                    )
                                        : shortedData[k].rate > 60.00
                                        ? Row(
                                      children: [
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,)
                                      ],
                                    ) :  shortedData[k].rate > 40.00
                                        ? Row(
                                      children: [
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,)
                                      ],
                                    ) : shortedData[k].rate > 20.00
                                        ? Row(
                                      children: [
                                        Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,)
                                      ],
                                    ): Row(
                                      children: [
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                        Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,)
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(width: 20,),
                                Row(
                                  children: [
                                    Icon(Icons.event_note_outlined, color: AppColors.blue, size: 17,),
                                    SizedBox(width: 5,),
                                    Text("${(shortedData[k].rate/10).toStringAsFixed(0)}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.blue
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ) ;
                    },
                    selectedTextStyle: TextStyle(color: AppColors.blue, fontSize: 15,),
                    unselectedTextStyle: TextStyle(color: AppColors.blue.withOpacity(0.7), fontSize: 12),
                  )
                      : Center(child: Text("You don't have any Admirer yet!\nAdd new admirer.",
                      textAlign: TextAlign.center,
                    ),);
                }
              ),
            ),
          ],
        ),
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
