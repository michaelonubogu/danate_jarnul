import '../../utility/app_colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.size, required this.child, required this.onClick, this.bg = AppColors.mainColor
  }) : super(key: key);

  final Widget child;
  final Size size;
  final VoidCallback onClick;
  final Color? bg;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: size.width,
        height: 50,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
            child: child
        ),
      ),
    );
  }
}
