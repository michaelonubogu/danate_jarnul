import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../boxs/boxs.dart';
import '../../model/admirers_model/admirers_model.dart';
import '../../utility/app_colors.dart';
import '../admirer/add_profile.dart';

class AddJournals extends StatefulWidget {
  const AddJournals({Key? key}) : super(key: key);

  @override
  State<AddJournals> createState() => _AddJournalsState();
}

class _AddJournalsState extends State<AddJournals> {


  //empty admirers list
  List<AdmirerModel> admirerList = [];



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 30, right: 30, top: 50),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: ()=>showAdmirers(),
                  child: Container(
                    //width: size.width*.55,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(width: 1, color: Colors.blue)
                    ),
                    child: Row(
                      children: [
                        admirerList.isNotEmpty
                            ? Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.memory(admirerList[0].profile, height: 40, width: 40, fit: BoxFit.cover,),
                              ),
                              SizedBox(width: 10,),
                              Text("${admirerList[0].admirerName}",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textColor
                                ),
                              ),
                              SizedBox(width: 10,),
                              Icon(Icons.keyboard_arrow_down, color: Colors.grey,)
                            ],
                          )
                            :Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.asset("assets/images/profile.jpeg", height: 40, width: 40, fit: BoxFit.cover,),
                            ),
                            SizedBox(width: 10,),
                            Text("Choose Admirers",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textColor
                              ),
                            ),
                            SizedBox(width: 10,),
                            Icon(Icons.keyboard_arrow_down, color: Colors.grey,)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  children: [
                    InkWell(
                      onTap: ()=>_selectColor(),
                      child: Container(
                        width: 30, height: 30,
                        decoration: BoxDecoration(
                          color: pickerColor,
                          borderRadius: BorderRadius.circular(100)
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: (){},
                      child: Icon(Icons.check_box, size: 40, color: AppColors.mainColor,)
                    )
                  ],
                ),


                SizedBox(height: 30,),


                ///TODO: text editor

              ],
            )
          ],
        ),
      ),
    );
  }


  // create some values
  Color pickerColor = Color(0xff443a49);
  Color currentColor = Color(0xff443a49);
  bool _enableLabel = true;
  bool _portraitOnly = false;
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
    Navigator.pop(context);
  }

  _selectColor()async{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: const EdgeInsets.all(0),
          contentPadding: const EdgeInsets.all(0),
          content: SingleChildScrollView(
            child: MaterialPicker(
              pickerColor: pickerColor,
              onColorChanged: (color){
                changeColor(color);
              },
              enableLabel: _enableLabel,
              portraitOnly: _portraitOnly,
            ),
          ),
        );
      },
    );
  }

  //show admirer profiles
  Future<void> showAdmirers() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                contentPadding: EdgeInsets.all(10),
                titlePadding: EdgeInsets.only(top: 10, bottom: 0),
                actionsPadding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0))),
                title: Row(
                  children: [
                    IconButton(
                      onPressed: ()=>Navigator.pop(context),
                      icon: Icon(Icons.close),
                    ),
                    Text('Choose Admirers',
                      style: TextStyle(
                          color: AppColors.blue
                      ),
                    ),
                  ],
                ),
                content: Container(
                    height:300,
                    width: 300.0,
                    padding: EdgeInsets.only(top: 15, bottom: 0),
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(width: 1, color: AppColors.blue)
                        )
                    ),
                    child: Stack(
                      children: [
                        Boxes.getAdmirers.length != 0? ListView.builder(
                          shrinkWrap: true,
                          itemCount:  Boxes.getAdmirers.length,
                          itemBuilder: (_, index){
                            var data = Boxes.getAdmirers.getAt(index);

                            print("this is admirers $data");
                            return InkWell(
                              onTap: ()async{

                                setState(() async {
                                  admirerList.clear();
                                  admirerList.add(data!);
                                  Navigator.pop(context, true);
                                });

                                setState((){});
                              },
                              child: Container(
                                  height: 40,
                                  margin: EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5),
                                          child: Image.memory(data!.profile,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Text(data!.admirerName,
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },

                        ):Center(child: Text("No Admirer Profile."),),

                        Positioned(
                          bottom: 10, right: 10,
                          child: InkWell(
                            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>AddAdmirerProfile())),
                            child: Container(
                              width: 100,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColors.mainColor,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.add, color: Colors.white,),
                                  SizedBox(width: 5,),
                                  Text("Add",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                ),
              );
            }
        );
      },
    );
  }
}
