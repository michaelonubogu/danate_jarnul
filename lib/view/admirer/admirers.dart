import 'package:dante/database/local_database.dart';
import 'package:dante/json/admirors_json.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:alphabet_scroll_view/alphabet_scroll_view.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../boxs/boxs.dart';
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
    LocalDatabases.ADMIRER_PROFILE; //init database
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
                  print("this is admirer === ${data[0].userId}");
                  return AlphabetScrollView(
                    list: AdmirersListJson.admirersList.map((e) => AlphaModel(e["name"])).toList(),
                    itemExtent: 150,
                    itemBuilder: (_, k, id) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: ListTile(
                          //contentPadding: EdgeInsets.only(bottom: 20),
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network("${AdmirersListJson.admirersList[k]["profile"]}" , height: 50, width: 50, fit: BoxFit.cover,)),

                          title: Text("${AdmirersListJson.admirersList[k]["name"]}",
                            style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500
                            ),
                          ),
                          subtitle: Row(
                            children: [
                              Row(
                                children: [
                                  AdmirersListJson.admirersList[k]["rate"] == 3
                                  ? Row(
                                    children: [
                                      Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                      Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                      Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                    ],
                                  )
                                      : AdmirersListJson.admirersList[k]["rate"] == 2
                                      ? Row(
                                    children: [
                                      Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                      Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                      Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,)
                                    ],
                                  ) :  AdmirersListJson.admirersList[k]["rate"] == 1
                                      ? Row(
                                    children: [
                                      Icon(Icons.favorite, size: 20, color: AppColors.mainColor,),
                                      Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,),
                                      Icon(Icons.favorite_border, size: 20, color: AppColors.mainColor,)
                                    ],
                                  ) : Row(
                                    children: [
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
                                  Text("${AdmirersListJson.admirersList[k]["admirer"]}",
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
                      );
                    },
                    selectedTextStyle: TextStyle(color: AppColors.blue, fontSize: 15,),
                    unselectedTextStyle: TextStyle(color: AppColors.blue.withOpacity(0.7), fontSize: 12),
                  );
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
