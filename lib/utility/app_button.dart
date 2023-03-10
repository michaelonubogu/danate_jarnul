import 'package:dante/utility/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.size, required this.child, required this.onClick,
  }) : super(key: key);

  final Widget child;
  final Size size;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: size.width,
        height: 55,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: child
        ),
      ),
    );
  }
}
