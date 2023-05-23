import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';

import '../../utility/app_bar.dart';
import '../notification-json.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: AppTopBar(
                    size: size,
                    title: "Notification",
                    onBack: ()=>Navigator.pop(context),
                  isRightSideBar: false, onClickRight: () {  },

                ),
              ),
              Divider(height: 1, color: Colors.grey,),
            //  SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Recent",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15
                      ),
                    ),
                    Text("Mark all as read",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.blue,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: NotificationList.notification.length,
                  itemBuilder: (_, index){
                    var data = NotificationList.notification[index];
                    return Container(
                      width: size.width,
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: EdgeInsets.all(10),
                          width: 50, height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Image.asset(data["icon"], height: 30, width: 30, fit: BoxFit.contain,),
                        ),
                        title: Row(
                          children: [
                            Text("${data["title"]}",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                            SizedBox(width: 3,),
                            Text("${data["highlight_text"]}",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600
                              ),
                            ),

                          ],
                        ),
                      ),
                    );
                  },
                ),
              )



            ],
          ),
        ),
      ),
    );
  }
}
