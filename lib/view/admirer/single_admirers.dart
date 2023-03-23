import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import '../../model/admirers_model/admirers_model.dart';

class SingleAdmirers extends StatefulWidget {
  final AdmirerModel admirers;
  const SingleAdmirers({Key? key, required this.admirers}) : super(key: key);

  @override
  State<SingleAdmirers> createState() => _SingleAdmirersState();
}

class _SingleAdmirersState extends State<SingleAdmirers> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: AppColors.bgColor,
        leading: Container(
          margin: EdgeInsets.only(left: 12, top: 8, bottom: 8, right: 2),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(5),
          ),
          child: IconButton(
            onPressed: ()=>Get.back(),
            icon: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,),
          ),
        ),
        title: Text("Adam Smith",
          style: TextStyle(
            fontSize: 18,
            color: AppColors.textColor
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 20, top: 7, bottom: 7),
            width: 40, height: 40,
            decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
              onPressed: (){},
              icon: Icon(IconlyLight.edit,),
            ),
          )
        ],

      ),
      
      //body
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //profile
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.memory(widget.admirers.profile, height: 150, width: 150, fit: BoxFit.cover,),
                ),
                SizedBox(width: 20,),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.white,
                        border: Border.all(width: 1, color: AppColors.blue)
                      ),
                      child: Center(child: Text("See Journal",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),),
                    ),
                    SizedBox(height: 30,),
                    Text("Adam Smith",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black
                      ),
                    ),
                    SizedBox(height: 15,),
                    Row(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.date_range, color: AppColors.blue, size: 18),
                            SizedBox(width: 5,),
                            Text("January 14",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 15,),
                        Row(
                          children: [
                            Icon(Icons.favorite_border, color: AppColors.blue, size: 18,),
                            SizedBox(width: 3,),
                            widget.admirers.rate <= 0.00 && widget.admirers.rate >= 24.00
                                ? Text("Meh")
                                : widget.admirers.rate <= 25.00 && widget.admirers.rate >= 49.00
                                ? Text("Ok")
                                : widget.admirers.rate <= 5.00 && widget.admirers.rate >= 74.00
                                ? Text("Cute")
                                : Text("Sexy")
                          ],
                        )
                      ],
                    )
                  ],
                )


              ],
            ),

            SizedBox(height: 30,),

            //feature images
            Container(
              width: size.width,
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.admirers.featureImages.length,
                itemBuilder: (_, index){
                  return Container(
                    width: 140,
                    margin: EdgeInsets.only(right: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.memory(widget.admirers.featureImages[index], width: 140, height: 200, fit: BoxFit.cover,),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 30,),
            Text("Admirer’s Description",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10,),
            Text("${widget.admirers.description}",
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textColor,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 30,),
            Text("My Likes",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                itemCount: widget.admirers.myLikes.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: size.width,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Center(child: Icon(IconlyLight.heart, color: AppColors.white,),),
                        ),
                        SizedBox(width: 10,),
                       Text("${widget.admirers.myLikes[index]}"),
                      ],
                    ),
                  );
                }
              ),
            ),

            SizedBox(height: 30,),
            Text("My Dislikes",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.admirers.myDislikes.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: size.width,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.blue,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(child: Icon(Icons.thumb_down_alt_outlined, color: AppColors.white,),),
                          ),
                          SizedBox(width: 10,),
                          Text("${widget.admirers.myDislikes[index]}"),
                        ],
                      ),
                    );
                  }
              ),
            ),

            SizedBox(height: 30,),
            Text("Social Media",
              style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10,),
            SizedBox(
              height: 100,
              child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.admirers.socialMedia.length,
                  itemBuilder: (context, index) {
                    var socialMediaList = widget.admirers.socialMedia;
                    print("this is object === ${socialMediaList[index]}");
                    return Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Image.asset(
                          socialMediaList[index]["name"].contains("Facebook")
                              ? "assets/icons/fb.png"
                              :  socialMediaList[index]["name"].contains("Instagram")
                              ? "assets/icons/insta.png"
                              : socialMediaList[index]["name"].contains("Twitter")
                              ? "assets/icons/twitter.png"
                              : socialMediaList[index]["name"].contains("Google")
                              ? "assets/icons/fb.png"
                              : "assets/icons/fb.png" ,

                          height: 40, width: 40,),
                    );
                  }
              ),
            )
          ],
        ),
      ),
    );
  }
}
