import 'package:dante/boxs/boxs.dart';
import 'package:dante/model/journal_model/journal_model.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/journals/single_journal.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'add_Journals.dart';

class Journals extends StatefulWidget {
  const Journals({Key? key}) : super(key: key);

  @override
  State<Journals> createState() => _JournalsState();
}

class _JournalsState extends State<Journals> {
  //search controller
  final search = TextEditingController();
  final searchDate = TextEditingController();

  List<String> filterText = [
    "Shop By Time",
    "Shop By Name"
  ];

  bool isSearchByTime = false;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getJournal();
  }

  //initial current date & time appear
  List<JournalModel> journalList = [];
  getJournal()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken =  prefs.getString("token");
    print(Boxes.getJournal.length);

    for(var i = 0; i < Boxes.getJournal.length; i++){
      var data = Boxes.getJournal.getAt(i)!;
      print("journals === ${data!.title}");
      print("journals === ${data!.details}");
      if(data!.token == userToken){
        journalList.add(data);
      }

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
               isSearchByTime
                   ?  SizedBox(
                 width: size.width*.70,
                 child: TextFormField(
                   controller: searchDate,
                   onTap: ()=>selectDate(),
                   readOnly: true,
                   decoration: InputDecoration(
                       filled: true,
                       fillColor: Colors.white,
                       hintText: "Search by Date",
                       prefixIcon: Icon(Icons.search_outlined, size: 40,),
                       suffixIcon: Icon(Icons.calendar_month_outlined, size: 25,),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(10),
                         borderSide: BorderSide.none,
                       )
                   ),
                 ),
               )
                   : SizedBox(
                 width: size.width*.70,
                 child: TextFormField(
                   controller: search,
                   onChanged: (value){
                     searchJournal(value);
                   },
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
                DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    dropdownStyleData: DropdownStyleData(
                      width: 160,
                      padding: const EdgeInsets.symmetric(vertical: 6,),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 2,
                      offset: const Offset(0, 8),
                    ),
                   customButton: Container(
                     width: 58,
                     height: 58,
                     decoration: BoxDecoration(
                       color: AppColors.mainColor.withOpacity(0.8),
                       borderRadius: BorderRadius.circular(10),
                     ),
                     child: Center(
                       child: Image.asset("assets/images/filter.png", height: 40, width: 40,),
                     ),
                   ),
                    items: filterText
                        .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        if(value == "Shop By Time"){
                          isSearchByTime = true;
                        }else{
                          isSearchByTime = false;
                        }
                      });
                    },

                  ),
                ),

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

            isSearch
                ?searchList.isNotEmpty ? Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchList.length,
                itemBuilder: (context, index){
                  var data = searchList[index]!;


                  return InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleJournal(journalModel: data,))),
                    child: Container(
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
                              Text(DateFormat.yMMMd().format(DateTime.parse("${data.dateTime}")),
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
                    ),
                  );
                },
              ),
                )
                :Center(child: Text("No journal found!"),)

                : isDateSearchList
                ?searchJournalWithDateList.isNotEmpty ? Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: searchJournalWithDateList.length,
                itemBuilder: (context, index){
                  var data = searchJournalWithDateList[index]!;


                  return InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleJournal(journalModel: data,))),
                    child: Container(
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
                              Text(DateFormat.yMMMd().format(DateTime.parse("${data.dateTime}")),
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
                    ),
                  );
                },
              ),
            )
                :Center(child: Text("No journal found!"),)

                : journalList.isNotEmpty ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: journalList.length,
                    itemBuilder: (context, index){
                      var data = journalList[index]!;


                      return InkWell(
                        onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SingleJournal(journalModel: data,))),
                        child: Container(
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
                                  Text(DateFormat.yMMMd().format(DateTime.parse("${data.dateTime}")),
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
                        ),
                      );
                    },
                  ),
                ):Center(child: Text("No journal yet!"),)



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

  //initial current date & time appear
  List<JournalModel> searchList = [];

  bool isSearch = false;

  void searchJournal(String value) {
    print("this is search text === $value");
    if(value.isNotEmpty){
      searchList.clear();
      setState(() {
        isSearch =true;
      });
      if(journalList.isNotEmpty){
        for(var i in journalList){
          if(i.title.contains(value)){
            searchList.add(i);
          }
        }
      }

    }else{
      setState(() {
        isSearch =false;
      });
    }

    print("this is seqarch === ${isSearch}");
  }


  //Show journal with date & time appear
  List<JournalModel> searchJournalWithDateList = [];
  bool isDateSearchList = false;
  void searchJournalWithDate(String date) {
    print("this is search text === $date");
    if(date.isNotEmpty){
      searchJournalWithDateList.clear();
      setState(() {
        isDateSearchList =true;
      });
      if(journalList.isNotEmpty){
        for(var i in journalList){
          if(DateFormat.yMMMd().format(DateTime.parse("${i.dateTime}")).contains(date)){
            searchJournalWithDateList.add(i);
          }
        }
      }

    }else{
      setState(() {
        isDateSearchList =false;
      });
    }

    print("this is seqarch === ${isSearch}");
  }




  var selectedDate;
  //select date
  Future selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = DateFormat.yMMMd().format(picked);
        searchDate.text = selectedDate;
        searchJournalWithDate(selectedDate);
      });
  }

}
