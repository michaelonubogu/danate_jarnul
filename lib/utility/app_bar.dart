import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTopBar extends StatelessWidget {
  const AppTopBar({
    Key? key,
    required this.size, required this.title, required this.isRightSideBar, required this.onBack, required this.onClickRight,
  }) : super(key: key);

  final Size size;
  final String title;
  final bool isRightSideBar;
  final VoidCallback onBack;
  final VoidCallback onClickRight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 70, width: size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            padding: EdgeInsets.only(left: 4),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
                onPressed: onBack,
                icon: Icon(Icons.arrow_back_ios, color: Colors.black, size: 20,)),
          ),
          Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 17,
            ),
          ),

          isRightSideBar ? Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
                color: AppColors.mainColor.withOpacity(0.8),
                borderRadius: BorderRadius.circular(10)
            ),
            child: IconButton(
                onPressed: onClickRight,
                icon: Icon(Icons.edit_outlined, color: Colors.white,)),
          ):SizedBox(),

        ],
      ),
    );
  }
}
