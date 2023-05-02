import 'dart:io';
import 'dart:typed_data';
import 'package:dante/model/auth_model/email_verify_model.dart';
import 'package:intl/intl.dart';
import 'package:dante/controller/auth_controller/auth_controller.dart';
import 'package:dante/utility/app_button.dart';
import 'package:dob_input_field/dob_input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import '../../boxs/boxs.dart';
import '../../utility/app_colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  //Editing Controller
  final fName = TextEditingController();
  final lName = TextEditingController();
  final dob = TextEditingController();
  final email = TextEditingController();


  //image picker global variable
  final ImagePicker _picker = ImagePicker(); // this is Come from Image Picker Livery
  //it help use to take images

  //EMAIL
  var image, userid;
  Future showEmail()async{
    List userTokenList = [];
    List<LoginModel> users = [];

    SharedPreferences prefes = await SharedPreferences.getInstance();
    var token = prefes.getString("token");


    for(var i = 0; i < Boxes.getLogin.length; i ++){
      //store data with index
      var data = Boxes.getLogin.getAt(i);
      users.add(Boxes.getLogin.getAt(i)!);
      userTokenList.add(Boxes.getLogin.getAt(i)!.token);
    }
    userid = users[0]?.id;

    print("user id == ${userid}");

    var profile = await Boxes.getProfile.get("${userid}");

    //assign email
    setState(() {
      email.text = users[0].email;
    });

    //check token
    if(userTokenList.contains(token)){
     setState(() {
       //assign value
       image = profile?.profile;
       fName.text = (profile?.fName != null ? profile?.fName : "")!;
       lName.text = (profile?.lName != null ? profile?.fName : "")!;
       dob.text = (profile?.dob != null ? profile?.dob : "")!;
     });

     print("---- ${fName.text}");
   }


  }




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showEmail();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.bgColor,
          centerTitle: true,
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
          // leading: Container(
          //   width: 40, height: 40,
          //   margin: EdgeInsets.only(left: 10, top: 5, bottom: 5),
          //   decoration: BoxDecoration(
          //     color: Colors.grey.shade200,
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: Center(child: Icon(Icons.arrow_back_ios, size: 20, color: AppColors.textColor,)),
          // ),
          title: Text("Edif Profile",
            style: TextStyle(
                fontSize: 18,
                color: AppColors.textColor
            ),
          )
      ),

      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                height: 130,
                width: 130,
                //padding: EdgeInsets.all(40),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100)
                ),
                child:  InkWell(
                  onTap: ()=>openBottomSheet(),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: profileImage != null
                          ? Image.file(profileImage, height: 130, width: 130, fit: BoxFit.cover,)
                          : image !=null
                          ?  Stack(
                            children: [
                              Image.memory(Uint8List.fromList(image),  height: 130, width: 130,fit: BoxFit.cover, ),
                              Container(
                                height: 130,
                                width: 130,
                                //padding: EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                              )
                            ],
                          )
                          :  Padding(
                          padding: EdgeInsets.all(50),
                          child: Image.asset("assets/icons/upload_images.png", height: 40, width: 40, )
                      )
                  ),
                ),

              ),
            ),
            SizedBox(height: 15,),
            Center(
              child: Text("Edit Profile Picture",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            SizedBox(height: 50,),
            Text("First Name",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18, color: AppColors.textColor
              ),
            ),
            SizedBox(height: 12,),
            TextFormField(
              controller: fName,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "First Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 20,),

            Text("Last Name",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18, color: AppColors.textColor
              ),
            ),
            SizedBox(height: 12,),
            TextFormField(
              controller: lName,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Last Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 20,),

            Text("Date Of Birth",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18, color: AppColors.textColor
              ),
            ),
            SizedBox(height: 12,),
            TextFormField(
              onTap: ()=>selectDate(),
              readOnly: true,
              controller: dob,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "MM-DD-YYYY",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),
            SizedBox(height: 20,),

            Text("Email",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18, color: AppColors.textColor
              ),
            ),
            SizedBox(height: 12,),
            TextFormField(
              controller: email,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "johan@gmail.com",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none
                  )
              ),
            ),

            SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: AppButton(
                  size: size,
                  child: Text("Save Details",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.white
                    ),
                  ),
                  onClick: (){
                      if(profileImage != null){
                        AuthController.editProfile(fName.text, lName.text, dob.text, email.text, profileImage, userid, context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Upload your profile image."),
                          backgroundColor: Colors.red,
                          duration: Duration(milliseconds: 3000),
                        ));
                      }

                   }),
            ),
            SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }


  var selectedDate;
  Future selectDate() async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1920, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var data = "${selectedDate.toLocal()}".split(' ')[0];
        dob.text =  DateFormat('MM-dd-yyyy').format(DateTime.parse(data));
        print("dob.text ${dob.text}");
      });
  }



  //Open bottomsheet for select the method to upload images.
  Future openBottomSheet(){
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo),
                title: new Text('Gallery'),
                onTap: () {
                  uploadProfile(ImageSource.gallery); //it will take one parameter
                },
              ),

              ListTile(
                leading: new Icon(Icons.camera_alt_outlined),
                title: new Text('Camera'),
                onTap: () {
                  uploadProfile(ImageSource.camera); //it will take one parameter
                },
              ),
            ],
          );
        });
  }
  //Like Camera or Gallery


  // this is profile image store variable
  var profileImage, profileImageStr;
  //this method going take images and save local variable

  void uploadProfile(type) async{ // its take one parameter
    var image = await _picker.pickImage(source: type);
    setState(() {
      profileImage = File(image!.path); // store the image path in this local variable
      profileImageStr = image;
    });
    Navigator.pop(context); //when image taken, it will be close bottom sheets.
  }

}
