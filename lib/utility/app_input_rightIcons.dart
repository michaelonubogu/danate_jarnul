import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppInputRightIcon extends StatelessWidget {
  const AppInputRightIcon({
    Key? key, this.icon = Icons.keyboard_arrow_down,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          border: Border.all(width: 1, color: AppColors.blue),
          color: AppColors.blue.withOpacity(0.2)
      ),
      child: Icon(icon, color: AppColors.blue, size: 18,),
    );
  }
}
