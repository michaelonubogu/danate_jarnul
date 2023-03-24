import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:table_calendar/table_calendar.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  Positioned(
                      right: 0, top: 12,
                      child: IconButton(onPressed: (){}, icon: Icon(IconlyLight.notification, color: AppColors.white,))),
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
                    weekendDays: [DateTime.friday],
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
                      setState(() {
                        _selectedDay = selectedDay;
                        _focusedDay = focusedDay;
                        selectDate = true;
                      });
                      SearchDay =
                      (DateFormat("yyyy-MM-dd").format(_selectedDay!));
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
                children: [
                  Text("Current Dates",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textColor
                    ),
                  ),
                  SizedBox(height: 30,),



                ],
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          //Get.to(AddAdmirerProfile(), transition: Transition.rightToLeft);
          // Add your onPressed code here!
        },
        label: const Text('Add Date'),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.mainColor,
      ),
    );
  }
}
