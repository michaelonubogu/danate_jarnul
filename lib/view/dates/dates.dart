import 'dart:async';
import 'dart:convert';

import 'package:dante/model/dates_model/dates_screen_model.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/dates/single_dates.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../boxs/boxs.dart';
import '../notification/notification.dart';
import 'add_dates.dart';
class DatesList extends StatefulWidget {
  const DatesList({Key? key}) : super(key: key);

  @override
  State<DatesList> createState() => _DatesListState();
}

class _DatesListState extends State<DatesList> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final dateFormate = DateFormat.yMMMMd('en_US');
  late final monthOfTheYear = DateFormat.yMMM().format(DateTime.now());
  late dynamic toMonth;
  var monthFormat = DateFormat("yyyy-MM");
  dynamic toDay;
  dynamic month = DateFormat("yyyy-MM").format(DateTime.now());
  dynamic SearchDay;
  bool selectDate = false;
  bool selectMonth = false;
  var currentMonthYear = DateTime.now().month;
  double calenderheight = 180.00;

  var currentDates = DateFormat.yMMMd().format(DateTime.now());




      bool isLoading = false;

  //empty admirer model list
  List<DatesModel> datesModel = [];
  List<DatesModel> currentDatesModel = [];




  getDates() async{
    setState(() => isLoading = true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userToken = await prefs.getString("token");


    if(Boxes.getDates.length != 0){
      for(var i = 0; i < Boxes.getDates.length; i ++){
        var data = Boxes.getDates.getAt(i);
        print("this is date===== ${Boxes.getDates.getAt(i)?.title}");
        if(data?.token == userToken){
          datesModel.add(data!);
          // if(datesModel[i].date.contains(currentDates)){
          //   currentDatesModel.add(datesModel[i]);
          // }
        }
      }

      for(var i = 0; i < datesModel.length; i ++){
        if(datesModel[i].date.contains(currentDates)){
          currentDatesModel.add(datesModel[i]);
        }
      }

    }
    setState(() => isLoading = false);

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDates();
  }



  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        //padding: EdgeInsets.all(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: calenderheight,
              padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
              decoration: BoxDecoration(
                color: AppColors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                )
              ),
              child: Stack(
                children: [
                  // Positioned(
                  //     right: 0, top: 12,
                  //     child: IconButton(onPressed: (){
                  //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Notifications()));
                  //     }, icon: Icon(IconlyLight.notification, color: AppColors.white,))),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: (){
                        // setState(() {
                        //   _calendarFormat = CalendarFormat.month;
                        //   calenderheight+300.00;
                        // });
                      },
                      child: Container(
                          width: 50,
                          height: 3,
                          decoration: BoxDecoration(
                              color: AppColors.white.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(10)
                          ),
                        ),
                    ),
                  ),
                  TableCalendar(
                    firstDay: DateTime.utc(2022),
                    lastDay: DateTime.utc(2500),
                    focusedDay: _focusedDay,
                    rowHeight: 55,
                    calendarFormat: _calendarFormat,
                    calendarStyle: CalendarStyle(
                      cellMargin: EdgeInsets.only(top: 15),
                      cellPadding: EdgeInsets.all(5),
                      outsideDaysVisible: true,
                      defaultDecoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        shape: BoxShape.circle,
                        //borderRadius: BorderRadius.circular(100),
                      ),
                        rangeHighlightScale: 30.0,
                      weekNumberTextStyle: TextStyle(
                        fontSize: 20
                      ),
                      markerSize: 100.0,
                        todayTextStyle: TextStyle(
                          fontSize: 13, color: AppColors.blue,
                        ),
                      todayDecoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle),
                      weekendTextStyle: TextStyle(color: AppColors.white,),
                      defaultTextStyle: TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600
                      ),
                      selectedTextStyle: TextStyle(
                        fontSize: 14,
                        color: AppColors.blue,
                          fontWeight: FontWeight.w600
                      ),
                      selectedDecoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle
                      ),
                    ),
                    daysOfWeekStyle: const DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        color: AppColors.white,
                      ),
                      weekendStyle: TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    weekendDays: [],
                    headerStyle: HeaderStyle(
                        titleCentered: true,
                        headerMargin: const EdgeInsets.only(top: 10, bottom: 15, left: 50, right: 50),
                        headerPadding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        titleTextStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: AppColors.white,
                        ),
                        formatButtonVisible: false,
                        leftChevronIcon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.grey.shade300,
                          size: 15,
                        ),
                        rightChevronIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey.shade300,
                          size: 15,
                        )),
                    selectedDayPredicate: (day) {
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      currentDatesModel.clear();
                      datesModel.clear();
                      getDates();
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        selectDate = true;
                      });
                      SearchDay =
                      (DateFormat("yyyy-MM-dd").format(_selectedDay!));
                      currentDates = DateFormat.yMMMd().format(_selectedDay!);
                      toDay = (dateFormate.format(_selectedDay!));
                      print(SearchDay);
                    },
                    onFormatChanged: (format) {
                      if (_calendarFormat != format) {
                        // Call `setState()` when updating calendar format
                        setState(() {
                          _calendarFormat = format;
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      setState(() {
                        selectMonth = true;
                      });
                      _focusedDay = focusedDay;
                      month = monthFormat.format(_focusedDay);
                      toMonth = (dateFormate.format(_focusedDay));
                    },
                  ),

                ],
              ),
            ),


            SizedBox(height: 30,),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Current Dates",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor
                    ),
                  ),
                  SizedBox(height: 20,),
                  isLoading
                      ? Center(child: CircularProgressIndicator(color: AppColors.mainColor,),)
                      : currentDatesModel.isNotEmpty
                      ? SizedBox(
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: currentDatesModel.length,
                        itemBuilder: (context, index) {
                         // Map<String, dynamic> location = jsonDecode("${currentDatesModel[index]?.location}");
                          var img = currentDatesModel[index]?.admirer["profile"]!;
                          return  buildDatesWidget(
                              size,
                              profile: Image.memory(img!, height: 60, width: 60, fit: BoxFit.cover,),
                              name: "${currentDatesModel[index]?.title}",
                              date: "${currentDatesModel[index]?.date}",
                              location: "${currentDatesModel[index]?.location["location"]}",
                              onClick: ()=>Get.to(SingleDates(datesModel: currentDatesModel[index],), transition: Transition.rightToLeft)
                          );
                        }
                    ),
                  ) : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(child: Text("Not found any current dates."),),
                  ),


                  SizedBox(height: 30,),
                  Text("Upcoming Dates",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor
                    ),
                  ),
                  SizedBox(height: 20,),
                 isLoading
                     ? Center(child: CircularProgressIndicator(color: AppColors.mainColor,),)
                     : datesModel.isNotEmpty
                     ? SizedBox(
                       child: ListView.builder(
                           physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                          itemCount: datesModel.length,
                          itemBuilder: (context, index) {
                           var img = datesModel[index]?.userProfile.profile!;
                           return  datesModel[index]?.date.contains(currentDates) != true ? buildDatesWidget(
                            size,
                            profile: Image.memory(img!, height: 60, width: 60, fit: BoxFit.cover,),
                            name: "${datesModel[index]?.title}",
                            date: "${datesModel[index]?.date}",
                            location: "${datesModel[index]?.location}",
                            onClick: ()=>Get.to(SingleDates(datesModel: datesModel[index],), transition: Transition.rightToLeft)
                  ):SizedBox();
                         }
                       ),
                     ) : Padding(
                       padding: const EdgeInsets.only(top: 150),
                       child: Center(child: Text("No dates found. Create new dates."),),
                     ),


                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(AddDates(),  transition: Transition.rightToLeft);
          // Add your onPressed code here!
        },
        label: const Text('Add Date',
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

  Widget buildDatesWidget(Size size, {
    required Image profile,
    required String name,
    required String date,
    required String location,
    required VoidCallback onClick
 }) {
    return InkWell(
      onTap: onClick,
      child: Container(
                    width: size.width,
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: profile
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(name,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            ),
                            SizedBox(height: 8,),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/goblet.png", height: 18, width: 18,),
                                    SizedBox(width: 5.0),
                                    Text(date, style: TextStyle(fontSize: 13.0)),
                                  ],
                                ),
                                SizedBox(width: 10,),
                                Row(
                                  children: [
                                    Image.asset("assets/images/pin.png", height: 18, width: 18,),
                                    SizedBox(width: 5.0),
                                    SizedBox(
                                      width: size.width*.32,
                                      child: Text(location,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                          )),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
    );
  }


}
