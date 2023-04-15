import 'package:dante/utility/app_bar.dart';
import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SingleDates extends StatefulWidget {
  const SingleDates({Key? key}) : super(key: key);

  @override
  State<SingleDates> createState() => _SingleDatesState();
}

class _SingleDatesState extends State<SingleDates> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size; 
    return Container(
      color: AppColors.bgColor,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.bgColor,
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: AppTopBar(
                    size: size,
                    title: "Date Details",
                    isRightSideBar: true,
                    onBack: ()=>Get.back(),
                    onClickRight: (){}
                ),
              ),
              Divider(height: 1, color: Colors.grey,),
              SizedBox(height: 10,),
              Container(
                height: size.height-110,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network("https://newprofilepic2.photo-cdn.net//assets/images/article/profile.jpg", height: 45, width: 45,),
                          ),
                          SizedBox(width: 15,),
                          Text("Nayon Talukder",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blue
                            ),
                          )

                        ],
                      ),

                      SizedBox(height: 20,),
                      Text("Second Date w/Taylor",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 25,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Row(
                        children: [
                          Row(
                            children: [
                              Image.asset("assets/icons/bs_1.png", height: 30, width: 30,),
                              SizedBox(width: 5.0),
                              Text("Nov 22, 2023", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Row(
                            children: [
                              //Image.asset("assets/images/pin.png", height: 18, width: 18,),
                              Icon(Icons.watch_later_outlined, color: AppColors.mainColor, size: 30,),
                              SizedBox(width: 5.0),
                              Text("08: 30 AM", style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30,),
                      Text("Date Description",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Dec 20, 2018 — Basically, this widget will change the SafeArea colour without affecting your app background colour, due to the Container within,",
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(height: 30,),

                      //today's outfit
                      Text("Today's Outfit",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      SizedBox(
                        height: 180,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 10,
                          itemBuilder: (_, index){
                            return Container(
                              width: 130,
                              height: 180,
                              margin: EdgeInsets.only(right: 10),
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.network("https://media.glamour.com/photos/569643b3d9dab9ff41b580be/master/w_320%2Cc_limit/beauty-2012-06-0604-01-blush-beauty-products-every-woman-should-own_li.jpg", height: 130, width: 130, fit: BoxFit.cover,),
                                  ),
                                  SizedBox(height: 10,),
                                  Text("Blue Dress",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),


                      SizedBox(height: 30,),

                      //today's outfit
                      Text("All Reminder's",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: size.width*.60,
                                  child: Text("Don't forget keys!!",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width*.20,
                                  child: Text("08:00 AM",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text("Purse check and take a packet perfume.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: size.width*.60,
                                  child: Text("Don't forget keys!!",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width*.20,
                                  child: Text("08:00 AM",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text("Purse check and take a packet perfume.",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: size.width,
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(width: size.width*.60,
                                  child: Text("Don't forget keys!!",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black
                                    ),
                                  ),
                                ),
                                SizedBox(width: size.width*.20,
                                  child: Text("08:00 AM",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 10,),
                            Text("Purse check and take a packet perfume.",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey
                              ),
                            )
                          ],
                        ),
                      ),

                      SizedBox(height: 30,),

                      //Purse Check outfit
                      Text("Purse Check",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 15,),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 4,
                          itemBuilder: (context, index) {
                            return Container(
                              width: size.width,
                              height: 50,
                              margin: EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: AppColors.blue.withOpacity(0.3),
                                    ),
                                    child: Center(
                                      child: Text("${index+1}",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.blue
                                        ),
                                      ),),
                                  ),

                                  SizedBox(width: 10,),
                                  Text("Pocket Perfume",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black54
                                    ),
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                      SizedBox(height: 40,),

                    ],

                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
