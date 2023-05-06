import 'package:dante/boxs/boxs.dart';
import 'package:dante/model/admirers_model/admirers_model.dart';
import 'package:dante/model/journal_model/journal_model.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'add_Journals.dart';

class Journals extends StatefulWidget {
  const Journals({Key? key}) : super(key: key);

  @override
  State<Journals> createState() => _JournalsState();
}

class _JournalsState extends State<Journals> {
  //search controller
  final search = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJournal();
  }

  List<JournalModel> journalList = [];
  getJournal()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken =  prefs.getString("token");
    print(Boxes.getJournal.length);

    for(var i = 0; i < Boxes.getJournal.length; i++){
      var data = Boxes.getJournal.getAt(i)!;
      print("journals === ${data!.title}");
      print("journals === ${data!.details}");
      journalList.add(data);
    }
    setState(() {

    });

    print("this is journal === ${journalList}");

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width*.40,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Journals",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                          color: Colors.black
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("See all you Journals you've created so far.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black
                        ),
                      )
                    ],
                  ),
                ), 
                SizedBox(
                  width: size.width*.40,
                  child: Image.asset("assets/images/journal_top.png", height: 120, width: 120,),
                )
              ],
            ),

            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: size.width*.70,
                  child: TextFormField(
                    controller: search,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Search notes",
                      prefixIcon: Icon(Icons.search_outlined, size: 40,),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      )
                    ),
                  ),
                ),
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: AppColors.mainColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Image.asset("assets/images/filter.png", height: 40, width: 40,),
                  ),
                )
              ],
            ),


            SizedBox(height: 30,),
            Text("Recent edited",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54
              ),
            ),
            SizedBox(height: 20,),

            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: journalList.length,
                itemBuilder: (context, index){
                  var data = journalList[index]!;

               
                  return Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Color(data.color),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${data.title}",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: size.width*.40,
                              child: Row(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.memory(data.admirers["profile"], height: 40, width: 40, fit: BoxFit.cover,),
                                  ),
                                  SizedBox(width: 10,),
                                  Text("${data.admirers["name"]}",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textColor
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text("May 25, 2023",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textColor
                              ),
                            ),

                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            )



          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Boxes.getJournal.clear();
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddJournals()));
          // Add your onPressed code here!
        },
        label: const Text('Create Journal',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 17
          ),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.mainColor,
      ),
    );
  }
}
