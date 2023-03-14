import 'package:dante/utility/app_colors.dart';
import 'package:dante/view/admirer/admirers.dart';
import 'package:dante/view/home/home.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _selectedIndex = 0; //current  page index

  //list of pages/widget
  List<Widget> pages = [
    Home(),
    Admirers(),
    Admirers(),
    Admirers(),
  ];

  //on tap method
  _onItemTapped(value){
    setState(() {
      _selectedIndex = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: AppColors.bgColor,
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 70,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: BottomNavigationBar(
            showUnselectedLabels: false,
            backgroundColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.calendar),
                label: '-',

              ),
              BottomNavigationBarItem(
                icon:  Icon(IconlyLight.heart),
                label: '-',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.event_note_outlined,),
                label: '-',
              ),
              BottomNavigationBarItem(
                icon: Icon(IconlyLight.profile),
                label: '-',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: AppColors.blue,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
