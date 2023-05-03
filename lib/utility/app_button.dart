import '../../utility/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.size, required this.child, required this.onClick, this.bg = AppColors.mainColor, this.borderColor = AppColors.mainColor
  }) : super(key: key);

  final Widget child;
  final Size size;
  final VoidCallback onClick;
  final Color? bg;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          color: bg,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: child
        ),
      ),
    );
  }
}
